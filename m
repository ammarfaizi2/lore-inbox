Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282931AbRK0Ubs>; Tue, 27 Nov 2001 15:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282933AbRK0Ubj>; Tue, 27 Nov 2001 15:31:39 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12789
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282931AbRK0Ubf>; Tue, 27 Nov 2001 15:31:35 -0500
Date: Tue, 27 Nov 2001 12:31:28 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ahmed Masud <masud@googgun.com>, "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011127123128.E9391@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Ahmed Masud <masud@googgun.com>,
	'lkml' <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111261825340.15932-100000@xanadu.home> <000901c17723$b641c990$8604a8c0@googgun.com> <3C03C96D.B3ACA982@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C03C96D.B3ACA982@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 09:12:13AM -0800, Andrew Morton wrote:
> Ahmed Masud wrote:
> > 
> > Just to add to the above something I've experienced:
> > 
> > 2.4.12 - 2.4.14 on a number of AMD Athelon 900 with 256 MB
> > RAM doing serial I/O would miss data while any DISK writes would
> > occure.
> 
> Two possibilities suggest themselves:
> 
> - Interrupt latency.   Last time I checked (a year ago), the worst-case
>   interrupt latency of the IDE drivers was 80 microseconds on a 500MHz PII.
>   That was with `hdparm -u 1'.   That's pretty good.
> 
>   Could you please confirm that you're using `hdparm -u 1' against the
>   relevant disk?
> 
> - The serial port is working OK, but the application which is handling
>   serial IO is blocked on a disk read (something got paged out), and
>   that disk read fails to complete by the time the serial port buffer
>   fills up.
> 
>   I'll send you a patch which makes the VM less inclined to page things
>   out in the presence of heavy writes, and which decreases read
>   latencies.
> 
Is this patch posted anywhere?
