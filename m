Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWIEMci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWIEMci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 08:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWIEMci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 08:32:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51628 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932192AbWIEMch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 08:32:37 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060904115845.GP4416@stusta.de> 
References: <20060904115845.GP4416@stusta.de>  <20060903220657.GG4416@stusta.de> <14367.1157361985@warthog.cambridge.redhat.com> 
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: frv compile error in set_pte() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Sep 2006 13:31:32 +0100
Message-ID: <9812.1157459492@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> It's a gcc 4.1.1 from ftp.gnu.org.

If you patch it with the attached patch, does it then work?

David

---
Index: gcc/config/frv/frv.h
===================================================================
--- gcc/config/frv/frv.h	(revision 116693)
+++ gcc/config/frv/frv.h	(working copy)
@@ -1376,6 +1376,9 @@ extern enum reg_class reg_class_from_let
    : (C) == 'U' ? EXTRA_CONSTRAINT_FOR_U (VALUE)			\
    : 0)
 
+#define EXTRA_MEMORY_CONSTRAINT(C,STR) \
+  ((C) == 'U' || (C) == 'R' || (C) == 'T')
+
 #define CONSTRAINT_LEN(C, STR) \
   ((C) == 'D' ? 3 : DEFAULT_CONSTRAINT_LEN ((C), (STR)))
 
