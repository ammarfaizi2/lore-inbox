Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVEDRgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVEDRgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVEDRgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:36:55 -0400
Received: from deliverator6.gatech.edu ([130.207.165.168]:13748 "EHLO
	deliverator6.gatech.edu") by vger.kernel.org with ESMTP
	id S261282AbVEDRfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:35:38 -0400
To: linux-kernel@vger.kernel.org
Subject: macro in linux/compiler.h pollutes gcc __attribute__ namespace
From: Timmy Douglas <timmy+lkml@cc.gatech.edu>
Date: Wed, 04 May 2005 13:35:08 -0400
Message-ID: <87vf5y99o3.fsf@mail.gatech.edu>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm not subscribed so please CC me replies that you want me to reply
to.)

Recently I've found a problem with emacs where gcc optimizes a
function to be inline where it shouldn't be. The emacs developers use
a macro like this:

#define NO_INLINE __attribute__((noinline))

that would normally work fine but when we compile the file with
NO_INLINE, the -E output looks like:

static void __attribute__(())
x_error_quitter (display, error)
     Display *display;
     XErrorEvent *error;
{
  char buf[256], buf1[356];

...etc


I've realized that this file includes linux/compiler.h which does:


   139
   140  #ifndef noinline
   141  #define noinline
   142  #endif
   143

which causes __atribute__((noinline)) to change into
__attribute__(()). I'm not sure how linux developers keep a function
from getting inlined, but I'm hoping someone will consider removing or
changing this macro.

