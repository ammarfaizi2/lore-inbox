Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWGIAJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWGIAJy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 20:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWGIAJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 20:09:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33434 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030426AbWGIAJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 20:09:53 -0400
Date: Sun, 9 Jul 2006 02:09:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Message-ID: <20060709000923.GA1694@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <200607090828.36834.ncunningham@linuxmail.org> <20060708235434.GG2546@elf.ucw.cz> <200607091002.48153.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607091002.48153.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > It's only too slow on swsusp. With Suspend2, I regularly suspend
> > > > > > 1GB images on both my desktop and laptop machines. I agree that it
> > > > > > might be slower on a
> > > >
> > > > uswsusp is as fast as suspend2. It does same LZF compression.
> > >
> > > I agree for uncompressed images - I tried timing the writing of the image
> > > yesterday. I'm not sure about LZF though, because I couldn't get it to
> > > resume. I'd be interested to see it really be as fast as suspend2 with
> > > compression.
> >
> > Is there any way to help you? I assume normal swsusp resumes okay so
> > it is not driver problem?
> 
> That's right. I'll see if I can figure it out tomorrow, Lord willing. I 
> have /dev/snapshot in my initrd but it gives that prompt asking for the 
> device name. By the way, will it sit there foreever, or does that have a 
> timeout?

AFAICT it will just sit there... Entering full path to resume device
should help at that point:

        while (stat(resume_dev_name, &stat_buf)) {
                printf("resume: Could not stat the resume device file.\n"
                        "\tPlease type in the file name to try again"
                        "\tor press ENTER to boot the system: ");
                fgets(resume_dev_name, MAX_STR_LEN - 1, stdin);
                n = strlen(resume_dev_name) - 1;
                if (n <= 0)
                        return ENOENT;
                if (resume_dev_name[n] == '\n')
                        resume_dev_name[n] = '\0';
        }

BTW the way I get this to work is very hacky: just force root
filesystem to be ext2, then boot with init=/bin/bash, and launch
resume manually. I guess I should prepare myself proper initrd...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
