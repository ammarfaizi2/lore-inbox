Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267807AbTBYHyS>; Tue, 25 Feb 2003 02:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbTBYHyS>; Tue, 25 Feb 2003 02:54:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:22150 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267807AbTBYHyR>;
	Tue, 25 Feb 2003 02:54:17 -0500
Date: Tue, 25 Feb 2003 00:04:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: braam@clusterfs.com, linux-kernel@vger.kernel.org,
       david+cert@blue-labs.org
Subject: Re: [OOPS] 2.5.62, bootup, do_add_mount
Message-Id: <20030225000448.6f5e0d22.akpm@digeo.com>
In-Reply-To: <20030225080350.GD1109@in.ibm.com>
References: <3E5700EA.9070905@blue-labs.org>
	<20030225080350.GD1109@in.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 08:04:25.0446 (UTC) FILETIME=[833E9860:01C2DCA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> 
> Hi Peter,
> 
> presto_get_sb() is returning error resulting in the following NULL 
> pointer reference in do_kern_mount(). The following patch corrects
> it.
> 

It should be returning some ERR_PTR value.  Seems that presto_get_sb() isn't
very careful in tracking the reason for the failed mount, so

	return ERR_PTR(-EINVAL);

should suffice.
