Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTBARdH>; Sat, 1 Feb 2003 12:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTBARdG>; Sat, 1 Feb 2003 12:33:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55300 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264919AbTBARdG>;
	Sat, 1 Feb 2003 12:33:06 -0500
Message-ID: <3E3C0684.4010806@pobox.com>
Date: Sat, 01 Feb 2003 12:40:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: NETIF_F_SG question
References: <004701c2ca03$cb467460$020120b0@jockeXP>
In-Reply-To: <004701c2ca03$cb467460$020120b0@jockeXP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joakim Tjernlund wrote:
> I am thinking of implementing harware scatter/gatter support( NETIF_F_SG) in my 
> ethernet driver. The network device cannot do HW checksuming.
> 
> Will the IP stack make use of the SG support and will there be any significant performance
> improvement?


No; you need HW checksumming for NETIF_F_SG to be useful.

If HW checksumming is not available, scatter-gather is useless, because 
the net stack must always make a pass over the data to checksum it. 
Since it must do that, it can linearize the skb at the same time, 
eliminating the need for SG.

	Jeff



