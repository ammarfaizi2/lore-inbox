Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270065AbTGPCpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 22:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270079AbTGPCpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 22:45:42 -0400
Received: from usen-43x234x18x94.ap-USEN.usen.ad.jp ([43.234.18.94]:51390 "EHLO
	suisho.attrition.jp") by vger.kernel.org with ESMTP id S270065AbTGPCpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 22:45:41 -0400
Date: Wed, 16 Jul 2003 12:00:30 +0900
From: switch <switch@attrition.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1] on a vaio GR laptop (one more)
Message-ID: <20030716030030.GB12397@suisho.attrition.jp>
References: <20030715133816.GA1074@inferi.kami.home> <20030715140354.GB3365@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715140354.GB3365@inferi.kami.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 04:03:54PM +0200, Mattia Dongili wrote:
> > hi, here's some problems running the 1st 2.6 test kernel on this vaio
> > gr7k, a japanese model.
> > 
> > 1. I've lost the '|' (pipe) keystroke in console, showkey reports the
> >    following:
> >      0   press
> >      1   release
> >     55   release
> >      0   relesase
> >      1   release
> >     55   release
> >   This laptop is equipped with a japanese keyboard so the | key is just
> >   above the Yen key. This problem was already here in 2.5.7X (haven't
> >   tested previous kernels).
> >   Using an xterm give me the | key back using this config option:
> >       Option          "XkbModel"      "jp106"
> >       Option          "XkbLayout"     "jp"

hello, 

i recall having this happen in 2.5 (although i think it also occured under X).  
afaik this has to do with the new input system (check atkbd.c).  im not sure if 
this is the correct fix, but i simply modified my jp106 keymap:

--- jp106.map.orig      2003-07-16 11:40:25.000000000 +0900
+++ jp106.map   2003-07-16 11:40:00.000000000 +0900
@@ -64,3 +64,6 @@
 keycode  97 = Control
 keycode 124 = backslash        bar
        control keycode 124 = Control_backslash
+keycode 183 = backslash        bar
+        control keycode 183 = Control_backslash
+

(i left the 124 there because i sometimes go back into 2.4 kernels)
and i think i needed to recompile my loadkeys (from kbd-1.08) as
addkey didnt like the 183 index (due to KEY_MAX, iirc).

hope that works/is the correct way to deal with this issue.
