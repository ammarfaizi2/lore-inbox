Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWECUX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWECUX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWECUX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:23:57 -0400
Received: from dougal.buttersideup.com ([195.200.137.69]:216 "EHLO
	dougal.buttersideup.com") by vger.kernel.org with ESMTP
	id S1750810AbWECUX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:23:57 -0400
Message-ID: <4459119D.10905@buttersideup.com>
Date: Wed, 03 May 2006 21:25:01 +0100
From: Tim Small <tim@buttersideup.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Gross, Mark" <mark.gross@intel.com>,
       bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Subject: Re: Problems with EDAC coexisting with BIOS
References: <C1989F6360C8E94B9645F0E4CF687C08C1E9FB@pgsmsx412.gar.corp.intel.com> <1145888979.29648.56.camel@localhost.localdomain>
In-Reply-To: <1145888979.29648.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2006-04-24 at 22:15 +0800, Ong, Soo Keong wrote:
>  
>
>>To me, periodical is not a good design for error handling, it wastes
>>transaction bandwidth that should be used for other more productive
>>purposes.
>>    
>>
>
>The periodical choice is mostly down to the brain damaged choice of NMI
>as the viable alternative, which is as good as 'not usable'
>  
>
Hi,

As I believe that the majority of the bluesmoke/EDAC developers are 
(were) operating under the assumption that it would be possible to do 
something with NMI-signalled errors, I was wondering what the problems 
with using NMI-signalled ECC errors were?

Are there some systems states in which an incoming NMI throws a spanner 
in to the works in an unrecoverable way?  If this is the case, is it so 
on all x86/x86-64 systems, or just a subset, and is there no way to 
implement some sort of top half / bottom half style NMI handler 
cleanly?  As I am certainly not an x86 architecture expert, I would 
appreciate any input from the resident gurus ;o).

Quickly returning to the original problem - I know this isn't a proper 
API by any stretch of the imagination, and would require changes to 
existing BIOSs, but the EDAC module could reprogram the chipset 
error-signalling registers, so that an ECC error no longer triggers an 
SMI.  The BIOS SMI handler could then read the signalling registers, and 
leave the ECC registers well alone if ECC errors are not set to generate 
an SMI.

Cheers,

Tim.
