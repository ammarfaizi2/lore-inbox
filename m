Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUC1Aa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUC1Aa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:30:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262006AbUC1Aas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:30:48 -0500
Message-ID: <40661CA7.6030105@pobox.com>
Date: Sat, 27 Mar 2004 19:30:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com> <1030470000.1080257746@aslan.btc.adaptec.com> <406375B0.5040406@pobox.com> <1564440000.1080322989@aslan.btc.adaptec.com>
In-Reply-To: <1564440000.1080322989@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:
>  o Rebuilds

	> 90% kernel, AFAICS, otherwise you have races with
	requests that the driver is actively satisfying


>  o Auto-array enumeration

	userspace


>  o Meta-data updates for "safe mode"

	unsure of the definition of safe mode


>  o Array creation/deletion


	of entire arrays?  can mostly be done in userspace, but deletion
	also needs to update controller-wide metadata, which might be
	stored on active arrays.


>  o "Hot member addition"

	userspace prepares, kernel completes

[moved this down in your list]
>  o Meta-data updates for topology changes (failed members, spare activation)

[warning: this is a tangent from the userspace sub-thread/topic]

	the kernel, of course, must manage topology, otherwise things
	Don't Get Done, and requests don't do where they should.  :)

	Part of the value of device mapper is that it provides container
	objects for multi-disk groups, and a common method of messing
	around with those container objects.  You clearly recognized the
	same need in emd... but I don't think we want two different
	pieces of code doing the same basic thing.


	I do think that metadata management needs to be fairly cleanly
	separately (I like what emd did, there) such that a user needs
	three in-kernel pieces:
	* device mapper
	* generic raid1 engine
	* personality module

	"personality" would be where the specifics of the metadata
	management lived, and it would be responsible for handling the
	specifics of non-hot-path events that nonetheless still need
	to be in the kernel.



