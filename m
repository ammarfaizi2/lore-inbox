Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbREHMDW>; Tue, 8 May 2001 08:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132057AbREHMDN>; Tue, 8 May 2001 08:03:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61824 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132054AbREHMC7>; Tue, 8 May 2001 08:02:59 -0400
Date: Tue, 8 May 2001 08:02:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Hen, Shmulik" <shmulik.hen@intel.com>
cc: "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: RE: ioctl call for network device
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27218@hasmsx52.iil.intel.com>
Message-ID: <Pine.LNX.3.95.1010508075833.17408A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, Hen, Shmulik wrote:

> > struct ifreq has a member called ifr_data. It is a pointer. You can
> > put a pointer to any of your data, including the most complex structure
> > you might envision, in that area. This allows you to pass anything
> > to and from your module. This pointer can be properly dereferenced
> > in kernel space but you should use copy_to/from_user and friends so a
> > user-space coding bug won't panic the kernel.
> 
> How about a linked list ?
> Will the driver be able to follow the list where each node was dynamically
> allocated by the application ?
> Is there a size limit on the buffer ifr_data points to ? (AFAIK, Windows
> NDIS drivers limit to 1 page buffer =4096 bytes).
> 
> 
> 	Thanks,
> 
> 	Shmulik Hen      
> 	Linux Advanced Networking Services
> 	Intel Network Communications Group

Again; This is a pointer. Your driver can dereference any valid pointer.
You can't do this while holding a lock that will prevent page faults.
Other than this, there are no problems.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


