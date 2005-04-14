Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVDNTY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVDNTY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVDNTY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:24:56 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:15332 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261599AbVDNTYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:24:54 -0400
Message-ID: <425EC364.1030107@austin.rr.com>
Date: Thu, 14 Apr 2005 14:24:20 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org, Alexander Nyberg <alexn@dsv.su.se>,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH 1/3] cifs: md5 cleanup - functions
References: <OFF8FD24BE.BDEDEA22-ON87256FE0.00741B4F-86256FE0.0074FC27@us.ibm.com> <1113267099.5734.1.camel@smfhome.smfdom> <20050412210152.GB25512@electric-eye.fr.zoreil.com>
In-Reply-To: <20050412210152.GB25512@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:

>Btw nobody cared about fs/cifs/connect.c::CIFSNTLMSSPNegotiateSessSetup
>(indentation from Mars + unchecked allocations before dereferences).
>
>--
>Ueimor
>  
>
That routine is disabled by default (as with the SPNEGO one) so it has 
not gotten much attention, it will probably go away or be significantly 
changed when someone goes through and collapses the four SessionSetup 
cases (currently each a distinct large function with only the default 
NTLM SessionSetup enabled by default) down to smaller functions with 
invoke some common functions.   A good time to do this would be when a 
SessionSetupOldStyle routine is added to handle pre-Windows NT4 
SessionSetup (OS/2, LAN Server, LAN Manager etc.).   Another possibility 
for a good time to update these routines is when SPNEGO support is 
finished - the SPNEGO SessionSetup (which is also too big a function) 
will change a lot (and get simpler) if Andrew Bartlett's idea of an 
upcall to the ntlm_auth utility (the man page is somewhat out of date 
from the better Samba 4 version of this see  
http://www.samba.org/samba/docs/man/ntlm_auth.1.html but it gives the 
general idea)  is done for that case - so that might be a good time to 
redo the session setup routines.

NTLMSSP authentication protocol is interesting (and the Davenport guys 
did a great job updating the documentation for it - see  
http://davenport.sourceforge.net/ntlm.html) and I would like to 
implement some of the cool optional features as I get time.
