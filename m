Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161299AbWGJC0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161299AbWGJC0m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 22:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161301AbWGJC0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 22:26:41 -0400
Received: from nwd2mail11.analog.com ([137.71.25.57]:51461 "EHLO
	nwd2mail11.analog.com") by vger.kernel.org with ESMTP
	id S1161299AbWGJC0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 22:26:41 -0400
X-IronPort-AV: i="4.06,221,1149480000"; 
   d="scan'208"; a="4461443:sNHT22700230"
Message-Id: <6.1.1.1.0.20060709193540.01ec8370@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Sun, 09 Jul 2006 22:26:39 -0400
To: kai@germaschewski.name
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: ./scripts/kallsyms.c question
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The application kallsyms generate assembler source containing symbol 
information, where "symbol information" is in these pre-defined names:

  _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext

I am working with a processor (Blackfin) which uses these plus two others 
_stext_l1, and _etext_l1.

I can add these in the same fashion as the existing (see below), but was 
wondering if this shouldn't be re-structured with a struct/loop rather than 
the existing n lines of if/else?

Thanks
-Robin

--- ./kallsyms.c.org    2006-04-02 15:42:50.000000000 -0400
+++ ./kallsyms.c        2006-04-02 15:57:25.000000000 -0400
@@ -43,7 +43,7 @@

  static struct sym_entry *table;
  static unsigned int table_size, table_cnt;
-static unsigned long long _stext, _etext, _sinittext, _einittext, 
_sextratext, _eextratext;
+static unsigned long long _stext, _etext, _sinittext, _einittext, 
_sextratext, _eextratext;
+static unsigned long long _stext_l1, _etext_l1;
  static int all_symbols = 0;
  static char symbol_prefix_char = '\0';

@@ -103,6 +103,10 @@
                 _sextratext = s->addr;
         else if (strcmp(sym, "_eextratext") == 0)
                 _eextratext = s->addr;
+       else if (strcmp(sym, "_stext_l1" ) == 0)
+               _stext_l1 = s->addr;
+       else if (strcmp(sym, "_etext_l1" ) == 0)
+               _etext_l1 = s->addr;
         else if (toupper(stype) == 'A')
         {
                 /* Keep these useful absolute symbols */
@@ -161,7 +165,8 @@
         if (!all_symbols) {
                 if ((s->addr < _stext || s->addr > _etext)
                     && (s->addr < _sinittext || s->addr > _einittext)
-                   && (s->addr < _sextratext || s->addr > _eextratext))
+                   && (s->addr < _sextratext || s->addr > _eextratext)
+                   && (s->addr < _stext_l1 || s->addr > _etext_l1))
                         return 0;
                 /* Corner case.  Discard any symbols with the same value as
                  * _etext _einittext or _eextratext; they can move between 
pass

