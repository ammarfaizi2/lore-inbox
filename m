Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUJZKkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUJZKkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 06:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUJZKkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 06:40:45 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:14799 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262208AbUJZKke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 06:40:34 -0400
Message-ID: <62112.195.245.190.94.1098787213.squirrel@195.245.190.94>
Date: Tue, 26 Oct 2004 11:40:13 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041026114013_41843"
X-Priority: 3 (Normal)
Importance: Normal
References: <20041022155048.GA16240@elte.hu> <20041025141628.GA14282@elte.hu>
       <33313.192.168.1.5.1098733224.squirrel@192.168.1.5>   
    <200410260827.39888.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410260827.39888.vda@port.imtp.ilyichevsk.odessa.ua>
X-OriginalArrivalTime: 26 Oct 2004 10:40:33.0319 (UTC) FILETIME=[38805370:01C4BB48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041026114013_41843
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Denis Vlasenko wrote:
>
> <shameless plug>
> Maybe this program will be useful. It is designed to give you
> overall system statistics without the need to scan entire /proc/NNN
> forest. Together with nice -20, it will hopefully not stall.
>
> Compiled with dietlibc. If you will have trouble compiling it,
> binary is attached too.
>
> Latest version is 0.9 but it seems I forgot it in my home box :(
</shameless plug>

Thanks for nmeter. I have changed a couple of little bits to build with
gcc-3.4 here (see diff attached).

Indeed, it says 0.7 as its version string. What's up on 0.9?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


------=_20041026114013_41843
Content-Type: text/plain; name="nmeter-1.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="nmeter-1.diff"

--- nmeter.c.orig	2004-10-26 10:01:00.579922368 +0100
+++ nmeter.c	2004-10-26 09:59:48.525876248 +0100
@@ -59,15 +59,15 @@
 char outbuf[4096];
 char *cur_outbuf = outbuf;
 
-extern inline void reset_outbuf() {
+inline void reset_outbuf() {
     cur_outbuf = outbuf;
 }
 
-extern inline int outbuf_count() {
+inline int outbuf_count() {
     return cur_outbuf-outbuf;
 }
 
-extern inline void print_outbuf() {
+inline void print_outbuf() {
     if(cur_outbuf>outbuf) {
 	write(1, outbuf, cur_outbuf-outbuf);
 	cur_outbuf = outbuf;
------=_20041026114013_41843--


