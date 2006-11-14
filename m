Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755380AbWKNCCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbWKNCCk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 21:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbWKNCCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 21:02:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:21621 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755380AbWKNCCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 21:02:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=R1tXDddFutFxVXW/9hnCj86e54wSLxhBP37U1ZidoTXI8HnR3rZxArf8NTO+LHoVRMnfiH6AY5w1bjwXZuyWSRURcYRkgQ9XI7qOFNu2K9iFOofXL0lBYfujVgEj8e4/yuFQ6beJfx159xyNK+XzPq74jZdzdltueXoh80nWro4=
Message-ID: <455923B5.3030608@gmail.com>
Date: Tue, 14 Nov 2006 11:02:29 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Mathieu Fluhr <mfluhr@nero.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
In-Reply-To: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mattieu Fluhr.

Mathieu Fluhr wrote:
> The problem is that, on SATA devices controlled by libata, on some big
> files (like for example a 600 MB file) the READ command seems to fail
> and outputs garbage (not 1 or 2 bytes diff, but the whole buffer).
>  -> This problem does not come out everytime, and each time on    
>     different sectors.
> 
> Please note that:
> - it is not chipset dependant (tested on nforce4 and sii3114)
> - it is not medium or device dependant

Hmmm... Interesting.  So, you're reading the media by directly issuing 
commands through the sg interface, right?  Can you please try the 
followings?

* Try using /dev/srX or /dev/scdX device instead of /dev/sgX.  You can 
use the command SG_IO but the code path is different, so it will help us 
rule out sg bug.

* Perform rounds of read-verify test using standard block interface (ie. 
simply opening /dev/srX and reading it).

[--snip--]
> - When I force the bus type to be IDE, our software will then send ATA
> commands. In this case, everything works like a charm. No errors at all.

What do you mean by 'sending ATA commands'?  libata exports all devices 
as SCSI devices.  For ATA devices, you can use ATA passthrough but you 
send CDBs to ATAPI devices anyway.

Thanks.

-- 
tejun
