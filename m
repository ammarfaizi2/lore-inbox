Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293110AbSBWHed>; Sat, 23 Feb 2002 02:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293111AbSBWHeX>; Sat, 23 Feb 2002 02:34:23 -0500
Received: from ns.suse.de ([213.95.15.193]:41989 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293110AbSBWHeR>;
	Sat, 23 Feb 2002 02:34:17 -0500
Date: Sat, 23 Feb 2002 08:34:16 +0100
From: Andi Kleen <ak@suse.de>
To: harish.vasudeva@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need some help with IP/TCP Checksum Offload
Message-ID: <20020223083416.A22421@wotan.suse.de>
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F280E6@caexmta9.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F280E6@caexmta9.amd.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 02:57:22PM -0800, harish.vasudeva@amd.com wrote:
> Hi All,
> 
>  I am trying to offload checksum calculation to my hardware. What i am doing in my driver (kernel 2.4.6) is :
> 
>  dev->features = NETIF_F_IP_CHECKSUM;
> 
>  Then, in my start_xmit( ) routine, i am parsing for the right headers & when i get the IP/TCP header, i print out the checksum & it is already the right checksum. When does the OS/Protocol offload this task? Am i missing something here?

For TX the checksum is only offloaded when you set and support NETIF_F_SG 
as well.  Otherwise the stack has to copy anyways and can compute the 
checksum during the copy operation.  Then with NETIF_F_SG the TX checksumming
will only be used with sendfile(), because that is the only way to do zero 
copy for now.

For RX you should set skb->ip_summed and skb->csum. The hardware checksum
is more useful in this case. 

-Andi
