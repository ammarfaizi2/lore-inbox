Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263806AbREYQxn>; Fri, 25 May 2001 12:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263808AbREYQxX>; Fri, 25 May 2001 12:53:23 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:65298 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S263806AbREYQxV>; Fri, 25 May 2001 12:53:21 -0400
Date: Fri, 25 May 2001 18:52:35 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: linux-kernel@vger.kernel.org, Norbert Preining <preining@logic.at>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: ac15 and 2.4.5-pre6, pwc format conversion
Message-ID: <20010525185235.D15193@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010525131502.I12364@arthur.ubicom.tudelft.nl> <XFMail.010525152244.nemosoft@smcc.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.010525152244.nemosoft@smcc.demon.nl>; from nemosoft@smcc.demon.nl on Fri, May 25, 2001 at 03:22:44PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 03:22:44PM +0200, Nemosoft Unv. wrote:
> On 25-May-01 Erik Mouw wrote:
> > On Fri, May 25, 2001 at 10:48:12AM +0200, Nemosoft Unv. wrote:
> > The format conversion shouldn't be there in the first place. Format
> > conversion is policy, so it doesn't belong in kernel. Note for example
> > that none of the sound drivers does sample rate conversion although
> > some sound chips are locked at 48kHz only.
> 
> True, but a number of audio tools will break, because they don´t support that
> samplerate (mpg123 0.59r, one of the more popular MP3 players, segfaults
> when it has to do conversion of 44.1 KHz to 48 KHz). Recording from such a
> source is usually less of a problem, although some post-processing is
> then necessary (not all tools support samplerate conversion natively).

I consider that a bug in mpg123. Examples for rate conversion have been
available for years, so fix mpg123.

> The situation for video devices is worse. 80% of the video tools will break
> if you limit the number of available palettes per driver. Plus, you will get
> severe fragmentation of which program works with which driver. Which is
> unacceptable, in my opinion (and certainly NOT the idea behind a common API!)

I consider this a bug in the tools. I've been working with real-time
video on sgi IRIX machines, and they do a couple of things right:

- The hardware supports a limited set of video formats. Most high end
  stuff (Onyx+Sirius, Octane+DV, Onyx2+DIVO) only supports a couple of
  YUV or YUVA formats (in studios YUV422 or YUV422+A is the most used).
  Low end workstations (Indy, O2) supports some "consumer" formats like
  RGB or Y as well.
- There are a couple of libraries (vl, cl, dmedia, audio, audiofile)
  that allows you to do all kinds of manipulations in userland.

Fortunately sgi also recognises this, and they're porting their
libraries to Linux (see oss.sgi.com).

> You can blame the authors of those video tools, but that´s not really fair.
> The original Video4Linux API was based upon TV grabber cards. Most of them
> do YUV/RGB conversion in hardware, so most tools expected that all or most
> palettes would always be available, since supporting a palette would not
> require any extra CPU cycles [1]. Some tools like RGB, and others YUV, so
> the authors happily selected the palette of their choice and never even
> considered building in functions for doing conversion. And then I am not even
> talking about the RGB/BGR mess.

The original V4L API was *implemented* first on TV grabber cards, but
was certainy written with other video equipment in mind. I remember I
looked at the API with the sgi stuff in mind, and considered it quite
sane.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
