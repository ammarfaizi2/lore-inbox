Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSFDXOz>; Tue, 4 Jun 2002 19:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316916AbSFDXOy>; Tue, 4 Jun 2002 19:14:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4107 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316715AbSFDXOy>;
	Tue, 4 Jun 2002 19:14:54 -0400
Message-ID: <3CFD499D.DF6EA8CF@zip.com.au>
Date: Tue, 04 Jun 2002 16:13:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <3CFD453A.B6A43522@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Here's a patch which is designed to make the kernel play more nicely
> with portable computers.

I just had a brainwave.  The following text has been added...


Aside: there is another reason why disks spin up more often than
necessary: an application has only read a part of a file, and it needs
to fetch more of that file later on.  This commonly happens with the
pagein of executables.  To fix this you can increase the readahead
tunable of your disk drive to something enormous (say, one gigabyte):

        blockdev --setra 2097152 /dev/hda

Once this is done, the readahead code will effectively read entire
files into memory when the application attempts to read just a small
part of that file.  So later access to other parts of that file will
not require another spinup.


-
