Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266484AbUHSCgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUHSCgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267966AbUHSCgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:36:12 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:59870 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S266484AbUHSCgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:36:09 -0400
Subject: Re: Problem with CIFS
From: Steve French <smfrench@austin.rr.com>
To: jra@samba.org, samba-technical@samba.org,
       linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1092882981.2822.12.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 18 Aug 2004 21:36:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Can you show me where the problem is ? 
>Currently in smbd/negprot.c we have :
>
> /* do spnego in user level security if the client
> supports it and we can do encrypted passwords*/ 
>
>  if (global_encrypted_passwords_negotiated &&
>            (lp_security() != SEC_SHARE) &&
>            lp_use_spnego() &&
>            (SVAL(inbuf, smb_flg2) & FLAGS2_EXTENDED_SECURITY)) {
>                negotiate_spnego = True;
>                capabilities |= CAP_EXTENDED_SECURITY;
>        }

I think Samba is just missing the else clause in smbd/negprot.c(since
reply_common sets FLAGS2_EXTENDED_SECURITY otherwise). Something like:

        else {
                remove_from_common_flags2(FLAGS2_EXTENDED_SECURITY);
                SSVAL(outbuf,smb_flg2,(SVAL(outbuf,smb_flg2) &
			 (~FLAGS2_EXTENDED_SECURITY)));
        }

but in any case I have to workaround it in the Linux cifs client by
paying more attention to the capability bit than to the actual smb flag



