Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbQKNJbP>; Tue, 14 Nov 2000 04:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130210AbQKNJbF>; Tue, 14 Nov 2000 04:31:05 -0500
Received: from 255.255.255.255.in-addr.de ([212.8.197.242]:21779 "HELO
	255.255.255.255.in-addr.de") by vger.kernel.org with SMTP
	id <S129878AbQKNJa4>; Tue, 14 Nov 2000 04:30:56 -0500
Date: Tue, 14 Nov 2000 08:49:49 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
Message-ID: <20001114084949.C723@marowsky-bree.de>
In-Reply-To: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com> <3A106380.CE41BBAE@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <3A106380.CE41BBAE@oracle.com>; from "Josue Emmanuel Amaro" on 2000-11-13T13:56:16
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2000-11-13T13:56:16,
   Josue Emmanuel Amaro <Josue.Amaro@oracle.com> said:

Good morning Josue,

I hope your certification matrix hasn't driven you mad yet ;-)

> While I do not think it would be productive to enter a discussion whether
> there is a need to fork the kernel to add features that would be beneficial
> to mission/business critical applications, I am curious as to what are the
> features that people consider important to have.

This is in fact the valuable subpart of the discussion.

Working for SuSE on High Availability, especially in the "enterprise" segment:
Here, referring to systems running databases (mostly Oracle, surprise),
ERP-Systems, but also providing services (NFS, Samba, firewalls) in such an
environment.

I personally need features which allow me to keep on running, shut down as
gracefully as possible if an error occurs, and if an error occured, diagnose
it out in the field.

This means: ECC memory, hotpluggable everything, proper error handling and
reporting in the kernel. Yes, christmas and easter do occur on the same day in
the real world, unfortunately.

This can best be summarised as "robustness".

If an error occured, I need to be able to fully diagnose it without having to
reproduce it - no, I do not wish to reproduce the error by crashing my
critical server on purpose, nor is "The error appears to have gone away, we
have no clue what it was" an acceptable answer. (kdb, LKCD, Oopsing to the
network etc: And they must be part of the default kernel as far as possible,
so they stay in sync and get widespread testing)

But also scalability: 2TB is a problem for me in some cases, 32bit just don't
cut it all the time - but I need to circumvent the storage problem even on a
32bit system. And adding disks to the system while running is desireable.

Cluster awareness, again mostly referring to storage: Yes, there is more than
one system accessing my SCSI bus, my FCAL RAID, and the error handling should
be architected in a way that they do not start reset wars.

The LVM should safeguard against multiple nodes changing the metadata. (Ok,
this can be solved in userspace too) LVM must be transactional, so a crash on
a node doesn't corrupt the data.

Basically, the talks in Miami (The Second Annual Linux Storage Management
Workshop) gave a great overview of everything I need.

And: I need all of this as Open Source. Period. No binary kernel modules do me
any good and I will pointedly ignore them.

Oh, and by the way - if any hot kernel hacker, not yet working on this full
time feels inspired to make this happen, contact me. Or any other Linux
company, as long as the job gets done. We'll be glad to make you a fulltime
kernel slave^Whacker! ;-)

> Another problem is how people define Enterprise Systems.  Many base it on the
> definitions that go back to S390 systems, others in the context of the 24/7
> nature of the internet.  That would also be a healthy discussion to have.
           _
24/7 * 99.99% mission/business critical services with "medium to high" load.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>
    Development HA

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
