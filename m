Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310298AbSBRJBo>; Mon, 18 Feb 2002 04:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310301AbSBRJBe>; Mon, 18 Feb 2002 04:01:34 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:27587 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S310298AbSBRJBW> convert rfc822-to-8bit; Mon, 18 Feb 2002 04:01:22 -0500
Importance: Normal
Subject: Re: [PATCH] linux-2.417 devfs 64bit portablility issue
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF88983DCC.7DF28A38-ONC1256B64.0036063F@de.ibm.com>
From: "Carsten Otte" <COTTE@de.ibm.com>
Date: Mon, 18 Feb 2002 11:01:14 +0100
X-MIMETrack: Serialize by Router on D12ML033/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 18/02/2002 10:02:55
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Richard!

>BTW: please don't send attachments. Send patches inline instead.
Sorry for sending the patch as attachment, but Notes messes
up whitespace so the patch would'nt apply if I include it directly.

>Sorry, but I find your approach grotesque. Apart from basic warts such
>as not declaring code+data as __init, the approach of populating the
>bitfield from yet another list doesn't appeal to me. I'd much rather
>see an approach which preserved the initialisation using bitmasks.
I do not think this patch is very nice either & it does not work at
all (the initialisation of the array is only called in error case).
I find the overall thing for registering/deregistering devices &
allocating majors very inconsistent.
devfs_alloc_major and devfs_register_*dev do hold the information
about which majors are allocated in two different places without
knowing about each other (bdops field and this private bitfield).
A good solution would be if *dev_register would never return a
major being statically allocated when called with major 0. If this is the
case, I do not see what alloc_major and dealloc_major are useful for.

mit freundlichem Gruﬂ / with kind regards
Carsten Otte

IBM Deutschland Entwicklung GmbH
Linux for eServer development - device driver team
Phone: +49/07031/16-4076
IBM internal phone: *120-4076
--
We are Linux.
Resistance indicates that you're missing the point!

