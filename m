Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbUCCECB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUCCECB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:02:01 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:64409 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262350AbUCCEB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:01:59 -0500
From: dan carpenter <error27@email.com>
To: Mike Fedyk <mfedyk@matchmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: bad: scheduling while atomic in nfs with 2.6.3
Date: Tue, 2 Mar 2004 20:15:43 -0800
User-Agent: KMail/1.5.4
References: <40454C6F.5020901@matchmail.com>
In-Reply-To: <40454C6F.5020901@matchmail.com>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403022015.43151.error27@email.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 March 2004 07:09 pm, Mike Fedyk wrote:
> I'm running 2.6.3-zonebal-lofft-slabfaz
> Call Trace:
>   [<c012258d>] __might_sleep+0x9d/0xe0
>   [<c01651d8>] deactivate_super+0x58/0x100
>   [<f89e9fba>] svc_export_put+0x7a/0x80 [nfsd]

The bad call path goes something like this:
svc_export_put() -> mntput() ->  __mntput() -> deactivate_super()
-> down_write() -> might_sleep()

I don't have a fix.  Neil Brown might.  I've CC'd him.

regards,
dan carpenter

