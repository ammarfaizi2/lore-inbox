Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129709AbRBNX46>; Wed, 14 Feb 2001 18:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131521AbRBNX4s>; Wed, 14 Feb 2001 18:56:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5651 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131519AbRBNX4l>; Wed, 14 Feb 2001 18:56:41 -0500
Subject: Re: [PATCH] pcnet32.c: MAC address may be in CSR registers
To: eli.carter@inet.com (Eli Carter)
Date: Wed, 14 Feb 2001 23:55:54 +0000 (GMT)
Cc: root@chaos.analogic.com (Richard B. Johnson), tsbogend@alpha.franken.de,
        alan@lxorguk.ukuu.org.uk (Alan Cox), P.Missel@sbs-or.de (Peter Missel),
        linux-kernel@vger.kernel.org, eli.carter@inet.com (Eli Carter)
In-Reply-To: <3A8B19BF.ED622DE5@inet.com> from "Eli Carter" at Feb 14, 2001 05:50:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TBm9-0006VH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +int is_valid_ether_addr( char* address )
> +{
> +    int i,isvalid=0;
> +    for( i=0; i<6; i++)
> +	isvalid |= address[i]; 
> +    return isvalid && !(address[0]&1);
> +}

static and why not

static inline int is_valid_ea(u8 *addr)
{
	return memcmp(addr, "\000\000\000\000\000\000", 6) && !(addr[0]&1);
}

That all assembles to nice inline code 8)

Looks ok to me, Im picking holes now

