Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTDHPII (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTDHPII (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:08:08 -0400
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:3306 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S261825AbTDHPIH (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 11:08:07 -0400
Date: Tue, 8 Apr 2003 17:19:26 +0200 (CEST)
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Emulating insns on Alpha
In-Reply-To: <yw1xistpqdqn.fsf@manganonaujakasit.e.kth.se>
Message-ID: <Pine.LNX.4.30.0304081714440.30553-100000@linux17.zdv.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Apr 2003, Måns Rullgård wrote:

> Falk Hueffner <falk.hueffner@student.uni-tuebingen.de> writes:
> > > Are there any patches around that emulate the BWX instruction set on
> > > older Alpha CPUs, or should I write it myself?
> >
> > There's an ancient one at
> > http://www.alphalinux.org/archives/axp-list/October1999/0500.html,
> > although it's probably easier to write it from scratch. I'd write the
> > whole thing in C, the trap is already so expensive that it's of no use
> > trying to be clever when emulating the particular instructions (except
> > when you replace the instruction with a jump to a stub, which seems
> > somewhat hairy, but feasible).
>
> If you think that's hairy, take a look at this:
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/tc2/tc2/include/Attic/tc2_autoload.h?rev=1.1.2.5&only_with_tag=dev-0_4&content-type=text/vnd.viewcvs-markup

Well, it'd be a lot hairier, since you need PALcode support to free temp
registers (unless I'm missing something). And you need to check access
rights (or jump back to userspace temporarily).

By the way, mb doesn't ensure that the instruction fetcher sees the new
code, you need imb. And the ret will probably confuse the branch
prediction stack.

	Falk

