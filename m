Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbQKSVHY>; Sun, 19 Nov 2000 16:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130148AbQKSVHN>; Sun, 19 Nov 2000 16:07:13 -0500
Received: from hermes.mixx.net ([212.84.196.2]:14602 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129904AbQKSVHC>;
	Sun, 19 Nov 2000 16:07:02 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
Date: Sun, 19 Nov 2000 21:37:21 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A183A01.4F214A4F@innominate.de>
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil> <3A117311.8DC02909@holly-springs.nc.us> <news2mail-3A15ACE3.5BED2CA3@innominate.de> <20001118164021.A156@toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 974666221 9141 10.0.0.90 (19 Nov 2000 20:37:01 GMT)
X-Complaints-To: news@innominate.de
To: Pavel Machek <pavel@suse.cz>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > Actually, I was planning on doing on putting in a hack to do something
> > like that: calculate a checksum after every buffer data update and check
> > it after write completion, to make sure nothing scribbled in the buffer
> > in the interim.  This would also pick up some bad memory problems.
> 
> You might want to take  look to a patch with crc loop option.
> 
> It does verify during read, not during write; but that's even better because
> that way you pick up problems in IO subsystem, too.

You would have to store the checksums on the filesystem then, or use a
verify-after-write.  What I was talking about is a
verify-the-buffer-didn't get scribbled.  I'd then trust the hardware to
report a write failure.  Note that if something scribbles on your buffer
between the time you put good data on it and when it gets transfered to
disk, you can verify perfectly and still have a hosed filesystem.

It was pointed out that you can't really do what I'm suggesting for
mmaped file data, and there's some truth to that - but certainly the
interval between when ->writepage gets called and when the actual buffer
write happens can be secured in this way.  Doing this only for metadata
is also a good idea because then the overhead would be close to nil and
the basic fs integrity would be protected.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
