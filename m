Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285963AbRL0DIw>; Wed, 26 Dec 2001 22:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285634AbRL0DIn>; Wed, 26 Dec 2001 22:08:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:57988 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S285073AbRL0DIl>;
	Wed, 26 Dec 2001 22:08:41 -0500
Date: Wed, 26 Dec 2001 22:08:40 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: readdir() loses entries on ramfs and tmpfs
Message-ID: <20011226220840.A32612@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.43.0112261932350.26802-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.43.0112261932350.26802-100000@marabou.research.att.com>; from proski@gnu.org on Wed, Dec 26, 2001 at 07:50:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2001 at 07:50:11PM -0500, Pavel Roskin wrote:
> I got a report that GNU Midnight Commander fails to erase some directories 
> on tmpfs from the first attempt.  However, it succeeds the next time.
[...]
>     while ((d = readdir(dir)) != NULL) {
> 	printf("%s\n", d->d_name);
> 	rmdir(d->d_name);
>     }
[...]
> I'm sorry, I cannot elaborate more, but the issue seems to be very 
> serious.

If Midnight Commander does similar to the above it's pretty silly...

In Perl I normally do something like this in a loop (with a max-loops
limiter):

	opendir
	@dirs = readdir(FOO);
	closedir
	last unless @dirs;
	&remove_the_dirs(@dirs);

Clearly that's slack since you could have a million files in a
directory, but you see the point.  readdir(2) and getdents(2)
are inherently racy.  If your code does not assume such and take
appropriate action, it's broken.

	Jeff


