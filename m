Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293043AbSBVXwu>; Fri, 22 Feb 2002 18:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293046AbSBVXwk>; Fri, 22 Feb 2002 18:52:40 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50319 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293043AbSBVXw3>; Fri, 22 Feb 2002 18:52:29 -0500
Date: Fri, 22 Feb 2002 18:52:22 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: harish.vasudeva@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need some help with IP/TCP Checksum Offload
Message-ID: <20020222185222.B16169@redhat.com>
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F280E6@caexmta9.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F280E6@caexmta9.amd.com>; from harish.vasudeva@amd.com on Fri, Feb 22, 2002 at 02:57:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 02:57:22PM -0800, harish.vasudeva@amd.com wrote:
> 
>  Then, in my start_xmit( ) routine, i am parsing for the right
> headers & when i get the IP/TCP header, i print out the checksum 
> & it is already the right checksum. When does the OS/Protocol 
> offload this task? Am i missing something here?

The network stack generates checksums for packets while copying, 
so the checksum offload feature is only used for packets that are 
not copied.  The easiest way to generate packets of this nature 
is to use the sendfile() syscall to transmit data from the page 
cache directly onto the wire.  If you need a couple of test 
programs I can forward a few to you offline.  Cheers,

		-ben
