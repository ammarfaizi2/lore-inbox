Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWAQF7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWAQF7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 00:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWAQF7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 00:59:38 -0500
Received: from smtpout.mac.com ([17.250.248.44]:47581 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751116AbWAQF7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 00:59:37 -0500
In-Reply-To: <20060117052758.GA22839@mythryan2.michonline.com>
References: <43CC5231.3090005@michonline.com> <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net> <20060117052758.GA22839@mythryan2.michonline.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <95E085A7-B910-4C01-BA6E-43971A6F5F97@mac.com>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: git-diff-files and fakeroot
Date: Tue, 17 Jan 2006 00:59:24 -0500
To: Ryan Anderson <ryan@michonline.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 17, 2006, at 00:27, Ryan Anderson wrote:
> On Mon, Jan 16, 2006 at 06:36:39PM -0800, Junio C Hamano wrote:
>> BTW, Ryan, I suspect this is where you try to append "-dirty" to  
>> the version number.  But I wonder why you are doing the build  
>> under fakeroot to begin with?  Wasn't the SOP "build as
>> yourself, install as root"?
>
> That's exactly what started this search, because I was running  
> "make deb-pkg". (Effectively.)  dpkg-buildpackage wants to think it  
> is running as root, either via sudo or via fakeroot.  I had my  
> build environment switched over entirely to fakeroot, as it just  
> seems to be a better practice, but I've temporarily switched back  
> to sudo.
>
> However, your explanation has pointed out to me how I can solve  
> this - run "fakeroot -u" instead of "fakeroot", and I think it will  
> be fixed.

You should run "make" first, then after that completes run "fakeroot  
make deb-pkg".  I think this is similar to what the Debian package  
"kernel-package" does, except it substitutes an alternate "debian/"  
directory.  IIRC, it just runs "make install" as a normal user to a  
staging directory, then runs "$(ROOTCMD) dpkg-deb -b [...]" to build  
the package.  IMHO it's somewhat of a cleaner solution, and I've used  
it for several years now with no issues.

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson



