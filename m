Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSFMCNu>; Wed, 12 Jun 2002 22:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSFMCNt>; Wed, 12 Jun 2002 22:13:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13831 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317402AbSFMCNs>; Wed, 12 Jun 2002 22:13:48 -0400
Message-ID: <3D07FFC6.6060004@zytor.com>
Date: Wed, 12 Jun 2002 19:13:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@mole.bio.cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
In-Reply-To: <Pine.SGI.4.33.0206130241230.4638397-100000@mole.bio.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> allocate_compression_buffers() currently allocates all buffers up
> smp_num_cpus which is fine without hotswap cpus. Once hotswap cpus path
> goes in, then the allocation will be (pseudo code):
> 
> 	for (i = 0; i < NR_CPUS; i++) {
> 		if (cpu_possible(i)) {
> 			ntfs_compression_buffer[i] = vmalloc();
> 			// TODO handle errors
> 		}
> 	}
> 
> That means in words that we allocate buffers only once and for all
> existing cpu SOCKETS, i.e. including all potentially hotpluggable cpus
> which are currently offline. - If someone invents hotpluggable cpu sockets
> at some point then they should be burnt at the stake! (-;
> 

Note that with my code, you don't allocate any memory until you have 
actually seen a particular CPU being *used.*  All very simple...

	-hpa


