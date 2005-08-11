Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVHKPZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVHKPZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVHKPZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:25:45 -0400
Received: from pat.uio.no ([129.240.130.16]:64653 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751084AbVHKPZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:25:44 -0400
Subject: Re: fcntl(F GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au, matthew@wil.cx, michael.kerrisk@gmx.net
In-Reply-To: <1123772802.8251.123.camel@lade.trondhjem.org>
References: <1123769192.8251.75.camel@lade.trondhjem.org>
	 <23689.1123771230@www9.gmx.net>
	 <1123772802.8251.123.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 11:25:20 -0400
Message-Id: <1123773920.8251.128.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.475, required 12,
	autolearn=disabled, AWL 2.34, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 11:06 (-0400) skreiv Trond Myklebust:

> -----
>  fcntl(SETLK)| effect on existing leases |
>      flag    | F_RDLCK   | F_WRLCK       |
>     ---------+---------------------------+
>      F_RDLCK | none      | none          |
>      F_WRLCK | recall    | none          |

Oops... That table applies to existing leases owned by your process. The
effect on leases owned by other processes is:

 fcntl(SETLK)| effect on other clients   |
     flag    | F_RDLCK   | F_WRLCK       |
    ---------+---------------------------+
     F_RDLCK | none      | recall        |
     F_WRLCK | recall    | recall        |

Cheers,
  Trond

