Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314601AbSDTKLt>; Sat, 20 Apr 2002 06:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSDTKLs>; Sat, 20 Apr 2002 06:11:48 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:2539 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314601AbSDTKLr>;
	Sat, 20 Apr 2002 06:11:47 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15553.12447.849592.261245@argo.ozlabs.ibm.com>
Date: Sat, 20 Apr 2002 19:10:55 +1000 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: peterson@austin.ibm.com, anton@au.ibm.com, mj@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: PowerPC Linux and PCI
In-Reply-To: <20020419.143839.15920500.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

>    From: James L Peterson <peterson@austin.ibm.com>
>    Date: Fri, 19 Apr 2002 16:37:03 -0500
> 
>    if (pci_read_config_dword(temp, PCI_VENDOR_ID, &l))
>      return NULL;
>         ....
>      memcpy(dev, temp, sizeof(*dev));
>     dev->vendor = l & 0xffff;
>     dev->device = (l >> 16) & 0xffff;
>    
>    It seems to me this is incorrect for a big-endian machine
>    (like PowerPC).  If we read the two 16-bit parts out of the
>    first 32-bit part, we will end up with:
> 
> pci_read_config_dword should do the byte swapping on &l for
> the caller, fix your pci_{read,write}_config_*() arch implementation.

It does, that's why it all works. :)  James Peterson seems to have
missed this fact, hence his confusion.

Paul.
