Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWAaK2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWAaK2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWAaK2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:28:14 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:394 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750731AbWAaK2N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:28:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ifC5CQVEeRD84Q8MMTDtAVTT20lmnJ5/cw/dWz2uXeTLfaf7g371r5p+Dg/G4PT7AoOD2dPNPC+aJGiwIaMUSC/YGtmhktEMBRzLrdXoFB4bYiPGRUZ3dDxiWBd7gfEeugqYfivxtZFmZ3NlLbKmPMll67xuo36CuUfdvbfbWlE=
Message-ID: <69304d110601310228k2e92fd05qbb25949b0d6e9196@mail.gmail.com>
Date: Tue, 31 Jan 2006 11:28:11 +0100
From: Antonio Vargas <windenntw@gmail.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>,
       pierre-olivier.gaillard@fr.thalesgroup.com,
       linux-kernel@vger.kernel.org
Subject: Re: Can on-demand loading of user-space executables be disabled ?
In-Reply-To: <43DF2332.3070705@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43DDE697.5000007@fr.thalesgroup.com>
	 <43DF2332.3070705@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> P.O. Gaillard wrote:
>
> > Hello,
> >
> > As far as I understand what happens when I start a Linux program, the
> > executable file is mmaped into memory and the execution of the code
> > itself prompts Linux to load the required pages of the program.
> >
> > I expect that this could cause unwanted delays during program
> > execution when a function that has never been used (nor loaded into
> > memory) is called. This delay could be bigger than 10ms while the 2.6
> > kernel is usually quite predictable thanks to Ingo Molnar and others'
> > work.
>
> Delays may indeed happen due to something that isn't yet loaded.  They
> may also
> happen because of something being swapped out due to memory pressure.
> Note that "turning off swap" by not having any swap-device won't help you.
> Linux knows that program code can be reloaded from the executable file,
> and may decide to drop little-used functions from memory.  They will then
> be demand-loaded if they ever are needed again.
>
> >
> > Is Linux really using on-demand loading ?
> > Is it very different from what I described in the first paragraph ?
>
> Not very.  Just note that linux doesn't load whole functions, it loads
> 4kB chunks called pages.
>
> > Can on-demand loading be disabled ? (This would seem convenient for my
> > applications since I generally start a program that is meant to run as
> > predictably as possible for months.)
>
> Probably possible. It would have to be a special use for this to make
> sense though,
> don't consider this just to have a "snappier desktop". Loading whole
> executables
> and keeping them loaded wastes lots of memory.  Usual programs have
> startup code
> that is only used once - it is normally nice that it gets dropped from
> memory
> after a while.  This frees up memory for everything else.  Similiarly,
> it is nice that
> the cleanup code used to end the program isn't loaded until needed, that
> way it doesn't waste space so the program have more memory available for
> work.
>
> Still, if the very occational and short page-in delay is too much for your
> specialized use - use mlock.  If demand loading or swapping merely is slow
> due to heavy disk usage, put the executables and swap on a spindle
> of its own so these disk accesses won't compete with data accesses.
>

the easy way to force all executables to be in ram all times is:

1. configure the box with zero swap

2. on boot, untar all your executable and .so files to a tmpfs mount.
this is in effect loading them into ram since you have no swap.

3. set the PATH and .so related vars so that all exe and .so files are
gotten from the tmpfs file.


--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
