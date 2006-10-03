Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWJCP6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWJCP6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWJCP6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:58:39 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:57067 "EHLO
	mail2.rfc1149.net") by vger.kernel.org with ESMTP id S1030239AbWJCP6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:58:38 -0400
To: jt@hpl.hp.com
Cc: Valdis.Kletnieks@vt.edu, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu> <20060929124558.33ef6c75.akpm@osdl.org> <200609300001.k8U01sPI004389@turing-police.cc.vt.edu> <20060929182008.fee2a229.akpm@osdl.org> <20061002175245.GA14744@bougret.hpl.hp.com>
Date: 03 Oct 2006 17:58:31 +0200
In-Reply-To: <20061002175245.GA14744@bougret.hpl.hp.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Samuel Tardieu <sam@rfc1149.net>
Organization: RFC 1149 (see http://www.rfc1149.net/)
Content-Transfer-Encoding: 8bit
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Message-Id: <2006-10-03-17-58-31+trackit+sam@rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jean" == Jean Tourrilhes <jt@hpl.hp.com> writes:

Jean> @@ -2500,9 +2501,9 @@ static int orinoco_hw_get_essid(struct o
Jean>  	len = le16_to_cpu(essidbuf.len);
Jean>  	BUG_ON(len > IW_ESSID_MAX_SIZE);
Jean>  
Jean> -	memset(buf, 0, IW_ESSID_MAX_SIZE+1);
Jean> +	memset(buf, 0, IW_ESSID_MAX_SIZE);
Jean>  	memcpy(buf, p, len);
Jean> -	buf[len] = '\0';
Jean> +	err = len;

Jean,

something bugs me here:

  - either buf is supposed to be a nul-terminated string, in which
    case if p is IW_ESSID_MAX_SIZE long there may be a bug (no '\0' at
    the end of buf)

  - either buf is not-supposed to be nul-terminated and the length
    value will always be used, in which case the memset() looks
    useless

I suggest that you revert the memset() to IW_ESSID_MAX_SIZE+1 so that
the last byte is cleared as well. Or am I missing something?

 Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

