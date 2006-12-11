Return-Path: <linux-kernel-owner+w=401wt.eu-S1762701AbWLKJj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762701AbWLKJj0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762702AbWLKJj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:39:26 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:41345 "EHLO
	liaag2af.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762701AbWLKJjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:39:25 -0500
Date: Mon, 11 Dec 2006 04:32:59 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: -mm merge plans for 2.6.20
To: Steve French <smfltc@us.ibm.com>
Cc: linux-cifs-client@lists.samba.org, Jeremy Allison <jra@samba.org>,
       simo <simo@samba.org>, Shirish S Pargaonkar <shirishp@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Message-ID: <200612110436_MC3-1-D49E-FE58@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <457CDC38.2090907@us.ibm.com>

On Sun, 10 Dec 2006 22:19:04 -0600, Steve French wrote:

> I don't remember any problems reported with plain text password
> support on current cifs and I have certainly seen it negotiated with no 
> problem,
> but I will double check with your reported flag combination.

I played around with it some more.

With SecurityFlags = 0x7 (default) the server asks for a plaintext
password and the client refuses.  That's fine.

With 0x37 the client agrees to send a plaintext password (or at least
fails to reject the server's request for one,) but actually sends:

<         ANSI Password Length: 24
<         Unicode Password Length: 24

<         ANSI Password: 3577D3557009178AFF455A0F7A99C6585CAEF99C515F2F2C
<         Unicode Password: 3577D3557009178AFF455A0F7A99C6585CAEF99C515F2F2C

(my password was aaaaaaaa).  This fails with error -13 (invalid password.)

With 0x30 the client sends:

>         Password Length: 24

>         Password: 61616161616161610000000000000000681C1DCF00002200

and everything works.

> > Also, the client doesn't automatically pick up the domain name from
> > smb.conf like smbfs does.
> >
> >   
> That is true, and is intentional.   cifs sends a domain of null (ie use 
> the server's
> default domain) - but it can be overridden on mount

That's OK then.  I just happened to notice it when I was comparing
traces of smbfs mounts to the ones from cifs.  Maybe the manpage should
mention this difference for those who are converting, though.

-- 
MBTI: IXTP
