Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUFCVMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUFCVMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 17:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUFCVMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 17:12:18 -0400
Received: from outside.osdl.org ([65.172.181.23]:23424 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264308AbUFCVL4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 17:11:56 -0400
Subject: Re: [BUG] NFS no longer updates file modification times
	appropriately
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040603202846.GA28479@tsunami.ccur.com>
References: <20040603202846.GA28479@tsunami.ccur.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086297112.3659.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 14:11:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 03/06/2004 klokka 13:28, skreiv Joe Korty:
> Trond,
>  Paraphrased from one of my inhouse customers: "The timestamp of an
> NFS-mounted file does not change when written to, when the below test is
> run on a 2.6.6-rc1 to 2.6.7-rc2 kernel.  The timestamp is appropriately
> updated when the test is run on a 2.6.5 kernel.  This is with NFSv3.
> The type of system serving up the files does not seem to be a factor."

NFS is only guaranteed to flush the file to disk when you do the
close(). Your program will just result in a lot of cached writes right
up until the moment it exits...

...and no - we do not update timestamps on the client side when we cache
the write, 'cos NFS does not provide any device for ensuring that clocks
on client and server are synchronized.

Cheers,
  Trond
