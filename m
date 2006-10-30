Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161415AbWJ3TQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161415AbWJ3TQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161417AbWJ3TQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:16:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25743 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161415AbWJ3TQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:16:39 -0500
Date: Mon, 30 Oct 2006 19:15:54 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       Stefan Schmidt <stefan@datenfreihafen.org>, dm-devel@redhat.com,
       dm-crypt@saout.de, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] dmsetup table output changed from 2.6.18 to 2.6.19-rc3 and breaks yaird.
Message-ID: <20061030191554.GN1319@agk.surrey.redhat.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
	Stefan Schmidt <stefan@datenfreihafen.org>, dm-devel@redhat.com,
	dm-crypt@saout.de, Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>
References: <20061030151930.GQ27337@susi> <20061030184331.GY3928@agk.surrey.redhat.com> <Pine.LNX.4.64.0610301053010.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610301053010.25218@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 11:00:29AM -0800, Linus Torvalds wrote:
> (maybe something like this trivial one? Totally untested, but it would 
> seem to be the sane approach)
 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index a625576..645e3ce 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -925,8 +925,7 @@ static int crypt_status(struct dm_target
>  		break;
>  
>  	case STATUSTYPE_TABLE:
> -		cipher = crypto_blkcipher_name(cc->tfm);
> -
> +		cipher = cc->cipher;
>  		chainmode = cc->chainmode;
>  
>  		if (cc->iv_mode)
> 
> 

Looks correct.

The point of STATUSTYPE_TABLE is to return (readable) output to userspace in
a format that the crypt_ctr() function would accept back in.

So crypt_ctr() now stores a private copy of cipher and chainmode for
crypt_status() to regurgitate when requested.

Alasdair
-- 
agk@redhat.com
