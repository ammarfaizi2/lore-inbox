Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUHRXCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUHRXCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUHRXCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:02:19 -0400
Received: from dp.samba.org ([66.70.73.150]:21225 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264704AbUHRXCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:02:13 -0400
Date: Wed, 18 Aug 2004 16:02:11 -0700
From: Jeremy Allison <jra@samba.org>
To: "Steve French (IBM LTC)" <smfltc@us.ibm.com>
Cc: linux-cifs-client@lists.samba.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-cifs-client] re: Problem with CIFS
Message-ID: <20040818230211.GD8700@legion.cup.hp.com>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040818120033.9DD101638C1@lists.samba.org> <41247C40.5DB76262@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41247C40.5DB76262@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 05:09:04AM -0500, Steve French (IBM LTC) wrote:
> 
> This is caused by an interesting bug in Samba, but one I should be able to
> workaround.  Basically Samba is setting a flag in the negotiate response saying
>     "I support extended security"
> which indicates that this frame should be decoded as if it contained an SPNEGO blob
> (ala RFC 2478) and a conflicting capability in the same frame which indicates
>     "I am not capable of extended security"
> The Samba server sets this SMB_FLAGS2_EXTENDED_SECURITY in the response even though
> the client said - no extended security (Windows gets this right). 
> ....
> The Samba fix is pretty easy as well (it only hits source/smbd/negprot.c -
> reply_negprot function), I will bounce the fix off jra before updating the Samba 3
> source.

Can you show me where the problem is ? Currently in smbd/negprot.c we have :

        /* do spnego in user level security if the client
           supports it and we can do encrypted passwords */
                                                                                                               
        if (global_encrypted_passwords_negotiated &&
            (lp_security() != SEC_SHARE) &&
            lp_use_spnego() &&
            (SVAL(inbuf, smb_flg2) & FLAGS2_EXTENDED_SECURITY)) {
                negotiate_spnego = True;
                capabilities |= CAP_EXTENDED_SECURITY;
        }

Which I thought should be correct.

Cheers,

	Jeremy.
