Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267373AbUHSU2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267373AbUHSU2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUHSU2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:28:35 -0400
Received: from dp.samba.org ([66.70.73.150]:387 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267374AbUHSU2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:28:19 -0400
Date: Thu, 19 Aug 2004 13:28:16 -0700
From: Jeremy Allison <jra@samba.org>
To: Steve French <smfrench@austin.rr.com>
Cc: jra@samba.org, samba-technical@samba.org,
       linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: Problem with CIFS
Message-ID: <20040819202816.GB13368@legion.cup.hp.com>
Reply-To: Jeremy Allison <jra@samba.org>
References: <1092882981.2822.12.camel@smfhome.smfdom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092882981.2822.12.camel@smfhome.smfdom>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 09:36:21PM -0500, Steve French wrote:
> >Can you show me where the problem is ? 
> >Currently in smbd/negprot.c we have :
> >
> > /* do spnego in user level security if the client
> > supports it and we can do encrypted passwords*/ 
> >
> >  if (global_encrypted_passwords_negotiated &&
> >            (lp_security() != SEC_SHARE) &&
> >            lp_use_spnego() &&
> >            (SVAL(inbuf, smb_flg2) & FLAGS2_EXTENDED_SECURITY)) {
> >                negotiate_spnego = True;
> >                capabilities |= CAP_EXTENDED_SECURITY;
> >        }
> 
> I think Samba is just missing the else clause in smbd/negprot.c(since
> reply_common sets FLAGS2_EXTENDED_SECURITY otherwise). Something like:
> 
>         else {
>                 remove_from_common_flags2(FLAGS2_EXTENDED_SECURITY);
>                 SSVAL(outbuf,smb_flg2,(SVAL(outbuf,smb_flg2) &
> 			 (~FLAGS2_EXTENDED_SECURITY)));
>         }
> 
> but in any case I have to workaround it in the Linux cifs client by
> paying more attention to the capability bit than to the actual smb flag

FYI: I just fixed this in the 3.x SVN tree. It won't be in 3.0.6
but should be in 3.0.7 and above. Thanks !

Jeremy.
