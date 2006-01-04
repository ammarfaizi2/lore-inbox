Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbWADK2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWADK2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWADK2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:28:17 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:61837 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S965226AbWADK2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:28:15 -0500
Date: Wed, 4 Jan 2006 11:28:13 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
Message-ID: <20060104102813.GA1515@vanheusden.com>
References: <20051108185349.6e86cec3.akpm@osdl.org>
	<437226B1.4040901@cosmosbay.com>
	<20051109220742.067c5f3a.akpm@osdl.org>
	<4373698F.9010608@cosmosbay.com> <43BB1178.7020409@cosmosbay.com>
	<Pine.LNX.4.61.0601041010180.29257@yvahk01.tjqt.qr>
	<43BB9F71.60909@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BB9F71.60909@cosmosbay.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Thu Jan  5 11:07:47 CET 2006
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>2) Reduces the size of (files_struct), using a special 32 bits (or 64bits)
> >>embedded_fd_set, instead of a 1024 bits fd_set for the close_on_exec_init 
> >>and
> >>open_fds_init fields. This save some ram (248 bytes per task)
> >>as most tasks dont open more than 32 files.
> >How do you know, have you done some empirical testing?
> 20 years working on Unix/linux machines yes :)
> Just try this script on your linux machines :
> for f in /proc/*/fd; do ls $f|wc -l;done
> more than 95% of tasks have less than 32 concurrent files opened.

0 root@muur:/home/folkert# for f in /proc/*/fd; do ls $f|wc -l;done | awk '{TOT+=$1; N++;} END{ print TOT / N, N; }'
13.7079 291

So on my system (running 291 processes (postfix, mysql, apache,
asterisk, spamassassin, clamav) it is on average 13.7 filehandles.
On an idle veritas netbackup server (130 processes): 4
On a system running 4 vmware systems (137 processes): 16
On a heavily used mailserver (130 processes, sendmail and MailScanner
package): 6,6


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
