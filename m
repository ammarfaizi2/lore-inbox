Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279860AbRKIMcn>; Fri, 9 Nov 2001 07:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279865AbRKIMcd>; Fri, 9 Nov 2001 07:32:33 -0500
Received: from mailer.zib.de ([130.73.108.11]:12994 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S279860AbRKIMcU>;
	Fri, 9 Nov 2001 07:32:20 -0500
Date: Fri, 9 Nov 2001 13:32:15 +0100
From: Sebastian Heidl <heidl@zib.de>
To: Matthew Clark <matt@eee.nott.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dev driver / pci throughput
Message-ID: <20011109133215.A792@csr-pc1.zib.de>
In-Reply-To: <Pine.OSF.4.31.0111091022010.26869-100000@perry>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.OSF.4.31.0111091022010.26869-100000@perry>; from matt@eee.nott.ac.uk on Fri, Nov 09, 2001 at 10:48:58AM +0000
X-www.distributed.net: 27 OGR packets (3.56 Tnodes) [4.21 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 10:48:58AM +0000, Matthew Clark wrote:
> #define CHUNK	512->4096 depending on implementation
> 
> static ssize_t BSL_write(..., const char *buf, size_t count..){
> char chunk[CHUNK];
> int	i,pos,
> 	for(i=0,pos=0;i<amount of data;i++,pos+=CHUNK){
> 		copy_from_user(buff,buf+pos,CHUNK);
> 		/* reorder data				*/
> 		/* not significant in throughput	*/
> 		for(k=0;k<CHUNK;k++){
>                         chunk[k]=buff[B_SM(j+k)];
> 			}
> 		memcpy_toio(MEM_reg+pos+i*CHUNK+j,chunk,CHUNK);
> 		}
> 	return count;
> 	}
> + lots of not important details-----
> 
> MEM_reg=ioremap(pci_resource_start(dev,B_SM_MEM)&PCI_BASE_ADDRESS_MEM_MASK,REG_SIZE);

Don't know if this will improve the performance much but if you checked the
area you are copying from with access_ok you can replace copy_from_user by
__copy_from_user. The second version does not check the area and so saves some
cycles.

regards,
_sh_


