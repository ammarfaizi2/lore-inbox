Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSGHD2V>; Sun, 7 Jul 2002 23:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSGHD2U>; Sun, 7 Jul 2002 23:28:20 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:38276 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S316770AbSGHD2T>; Sun, 7 Jul 2002 23:28:19 -0400
Message-Id: <5.1.0.14.2.20020708132813.0319ca08@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 08 Jul 2002 13:30:03 +1000
To: Andrew Morton <akpm@zip.com.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: direct-to-BIO for O_DIRECT
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
In-Reply-To: <3D2904C5.53E38ED4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:19 PM 7/07/2002 -0700, Andrew Morton wrote:
>Here's a patch which converts O_DIRECT to go direct-to-BIO, bypassing
>the kiovec layer.  It's followed by a patch which converts the raw
>driver to use the O_DIRECT engine.
>
>CPU utilisation is about the same as the kiovec-based implementation.
>Read and write bandwidth are the same too, for 128k chunks.   But with
>one megabyte chunks, this implementation is 20% faster at writing.
>
>I assume this is because the kiobuf-based implementation has to stop
>and wait for each 128k chunk, whereas this code streams the entire
>request, regardless of its size.
>
>This is with a single (oldish) scsi disk on aic7xxx.  I'd expect the
>margin to widen on higher-end hardware which likes to have more
>requests in flight.

i'll have a go at benchmark-testing these.

now have even bigger hardware than before: 2 x 2gbit/s FC HBAs in multiple 
dual-processor (Dual P3 Xeon 550MHz 2M L2 cache and Dual P3 Xeon 833MHz 
256K L2 cache) boxen, 8 x 15K RPM FC, 28 x 10K RPM SCSI.


cheers,

lincoln.

