Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbUKBX57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbUKBX57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUKBX55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:57:57 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:64920 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261373AbUKBX5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:57:07 -0500
Message-ID: <41882414.2070003@drdos.com>
Date: Tue, 02 Nov 2004 17:19:32 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey@galt.devicelogics.com
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jeff Garzik <jgarzik@pobox.com>, Brad Campbell <brad@wasp.net.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com> <4187F69E.9020604@drdos.com> <1099431477.7854.21.camel@lade.trondhjem.org> <20041102225304.GA11441@galt.devicelogics.com>
In-Reply-To: <20041102225304.GA11441@galt.devicelogics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@galt.devicelogics.com wrote:

>>Nope. I'm not seeing that at all (besides, that is entirely unrelated to
>>ESTALE errors).
>>
>>Mind telling us how to reproduce the problem?
>>
>>Cheers,
>>  Trond
>>
>>-- 
>>Trond Myklebust <trond.myklebust@fys.uio.no>
>>    
>>
>
>Connect 2.4.18 and 2.6.9 with NFS 3 enabled.  I am seeing problems 
>connecting and file size mismatches.  I also see errors with zero
>length files (host side) that get opened and populated with data
>and the remote side is unable to read them -- keeps seeing 
>them as zero length.  
>
>I can setup this back up tommorrow morning in the lab and provide 
>you all sorts of good debug and trace info.  The problem seems to 
>happen if the local side from the FS has open handles and starts
>writing blocks to a zero length file, and the remote side doesn't 
>seem to see the data right away.  
>
>On typical FS read behavior, even if the file has a zero length, this
>seems to be ignored and read requests continue until read returns
>0 bytes read for file size.  On the remote side, if the file size 
>is not reflected, this is not the behavior, and probably should 
>be.  I can see someone truncating or changing a file size and NFS 
>gets into a weird state.  
>
>Mismatches between configured v2/v3/v4 NFS configs between kernels
>also have some issues.  Please provide me with a sample /etc/exports
>config you wish me to use exporting a directory you think would be 
>helpful and I'll test and provide pcap traces of the traffic between
>the nodes.
>
>Jeff
>
> 
>
>  
>

