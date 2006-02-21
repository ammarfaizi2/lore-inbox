Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWBUV7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWBUV7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWBUV7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:59:34 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:2902 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964863AbWBUV7e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:59:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fVoyfWKR9oaNqShW7vSqbVdxgIzHWN/mgDVw2EMbvg2sgruiRTNHdlsN8A8EYt85llbyaEnQDP80ToZn0jjNAa7rTeXo9utiRD2Ph3E0O4bw1PAT2qziIvhMPx3E8dpvJe0tLU4gCp6Ig9YBL3f41Eb3buodJln1Xs9RX+s7cB0=
Message-ID: <9a8748490602211359m241aaff0v4f727bf0746e4829@mail.gmail.com>
Date: Tue, 21 Feb 2006 22:59:33 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: make -j with j <= 4 seems to only load a single CPU core
Cc: "Paul Fulghum" <paulkf@microgate.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602211653070.6016@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com>
	 <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com>
	 <1140558161.9838.8.camel@amdx2.microgate.com>
	 <9a8748490602211351v29c7804ew3a1305326941ea84@mail.gmail.com>
	 <Pine.LNX.4.61.0602211653070.6016@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Tue, 21 Feb 2006, Jesper Juhl wrote:
>
> > On 2/21/06, Paul Fulghum <paulkf@microgate.com> wrote:
> >> On Tue, 2006-02-21 at 22:10 +0100, Jesper Juhl wrote:
> >>
> >>> I should probably mention that the kernel I'm currently running and
> >>> observing this behaviour with is 2.6.16-rc4-mm1.
> >> ...
> >>>> I find this quite strange since anything from 'make -j 2' and up
> >>>> should be able to keep both cores resonably busy, but there seems to
> >>>> be a huge difference between j <= 4 and j > 4.
> >>
> >> I've seen the same thing (on Athlon 64x2 64 bit)
> >> but was not sure if it was a problem.
> >>
> >> The break point for me seems to be between -j 2 and -j 3
> >> -j 2 = serialized (or the appearance of)
> >> -j 3 = both cores mostly busy
> >>
> >> I'm pretty sure with an earlier 2.6 kernel source (but same environment)
> >> I did not see this. I'll start back tracking to earlier kernels
> >> to see if I can identify when this started.
> >>
> >
> > I know positively that I've seen this with previous 2.6.16-<something>
> > kernels, but not sure which ones exactely. I just dismissed it as
> > something that would probably be fixed soon and then today when I
> > build a few test kernels I noticed it again and thought "ohh, so it
> > didn't get fixed, better report it".
> >
> > I don't recall seeing it with 2.6.15 and earlier kernels, but I'm not
> > at all sure - especially since I only got this Athlon X2 box recently
> > and the first kernels I ever ran on it were 2.6.15-<something>.
> >
> > --
> > Jesper Juhl <jesper.juhl@gmail.com>
> > Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> > Plain text mails only, please      http://www.expita.com/nomime.html
>
> Could it be, simply, that you are now I/O bound with nothing
> for these CPUs to do in user-space, being busy handling the
> kernel I/O?
>

I doubt it.
If that was the case then I should be I/O bound with 'make -j 4' and
even more so with 'make -j 5'. But what I'm seeing is that with 'make
-j 4' (and less) only ~50% of my CPU resources are being used but with
'make -j 5' I get close to 100% CPU utilization.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
