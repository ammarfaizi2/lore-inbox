Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVIAQTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVIAQTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVIAQTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:19:46 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:32932 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1030224AbVIAQTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:19:46 -0400
Date: Thu, 1 Sep 2005 18:23:53 +0200
From: DervishD <lkml@dervishd.net>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [SOLVED] USB Storage speed regression since 2.6.12
Message-ID: <20050901162353.GA67@DervishD>
Mail-Followup-To: Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050901113614.GA63@DervishD> <4316EAD1.70300@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4316EAD1.70300@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Brice, again :)

 * Brice Goglin <Brice.Goglin@ens-lyon.org> dixit:
> Are you mounting this storage with vfat and 'sync' option ?
> IIRC, sync support for vfat was added around 2.6.12, making
> write way slower since it's now really synchron.

    That seems to be the problem. Mounting without 'sync' the speed
of transfers is almost infinite ;) but when doing a manual sync it
gives the usual speed of about 800Kb/sec (a little bit less, in
fact...). I've took a look at the ChangeLog for 2.6.12 and I cannot
find any reference to vfat and sync options, but the patch contains a
couple of references to MS_SYNCHRONIZE (or something like that), so
maybe was then when the "-o sync" honouring was added.

    I don't feel comfortable with an vfat mounted asynchronously, but
the new implementation seems to rewrite the fat on every single write
(that's the reason of the slowdown, probably), and since I'm not sure
about the quality of the flash memory present in the device, it is
very probable that it would wear the first sectors :( So I have to
mount it 'async' under 2.6.13; I didn't have to do that on older
kernels because the 'sync' was not honoured by vfat, so the fat was
updated asynchronously but the data were written synchronously (not
cached, at least).

    Thanks a lot for your help :))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
