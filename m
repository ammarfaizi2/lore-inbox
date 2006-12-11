Return-Path: <linux-kernel-owner+w=401wt.eu-S1762976AbWLKRXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762976AbWLKRXh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762977AbWLKRXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:23:37 -0500
Received: from pat.uio.no ([129.240.10.15]:53344 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762976AbWLKRXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:23:37 -0500
Subject: Re: [2.6.19] NFS: server error: fileid changed
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <751508.31195.qm@web32606.mail.mud.yahoo.com>
References: <751508.31195.qm@web32606.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 12:23:08 -0500
Message-Id: <1165857788.5721.127.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.174, required 12,
	autolearn=disabled, AWL 1.69, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 08:09 -0800, Martin Knoblauch wrote:
> Hi, [please CC me, as I am not subscribed]
> 
>  after updating a RHEL4 box (EM64T based) to a plain 2.6.19 kernel, we
> are seeing repeated occurences of the following messages (about every
> 45-50 minutes).
> 
>  It is always the same server (a NetApp filer, mounted via the
> user-space automounter "amd") and the expected/got numbers seem to
> repeat.

Are you seeing it _without_ amd? The usual reason for the errors you see
are bogus replay cache replies. For that reason, the kernel is usually
very careful when initialising its value for the XID: we set part of it
using the clock value, and part of it using a random number generator.
I'm not so sure that other services are as careful.

>  Is there a  way to find out which files are involved? Nothing seems to
> be obviously breaking, but I do not like to get my logfiles filled up. 

The fileid is the same as the inode number. Just convert those
hexadecimal values into ordinary numbers, then search for them using 'ls
-i'.

Trond

> [ 9337.747546] NFS: server nvgm022 error: fileid changed
> [ 9337.747549] fsid 0:25: expected fileid 0x7a6f3d, got 0x65be80
> [ 9338.020427] NFS: server nvgm022 error: fileid changed
> [ 9338.020430] fsid 0:25: expected fileid 0x15f5d7c, got 0x9f9900
> [ 9338.070147] NFS: server nvgm022 error: fileid changed
> [ 9338.070150] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
> [ 9338.338896] NFS: server nvgm022 error: fileid changed
> [ 9338.338899] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
> [ 9338.370207] NFS: server nvgm022 error: fileid changed
> [ 9338.370210] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
> [ 9338.634437] NFS: server nvgm022 error: fileid changed
> [ 9338.634439] fsid 0:25: expected fileid 0x7a6f3d, got 0x22070e
> [ 9338.698383] NFS: server nvgm022 error: fileid changed
> [ 9338.698385] fsid 0:25: expected fileid 0x7a6f3d, got 0x352777
> [ 9338.949952] NFS: server nvgm022 error: fileid changed
> [ 9338.949954] fsid 0:25: expected fileid 0x15f5d7c, got 0x5988c4
> [ 9339.042473] NFS: server nvgm022 error: fileid changed
> [ 9339.042476] fsid 0:25: expected fileid 0x7a6f3d, got 0x9f9900
> [ 9339.267338] NFS: server nvgm022 error: fileid changed
> [ 9339.267341] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
> [ 9339.309921] NFS: server nvgm022 error: fileid changed
> [ 9339.309923] fsid 0:25: expected fileid 0x15f5d7c, got 0x65be80
> [ 9339.405146] NFS: server nvgm022 error: fileid changed
> [ 9339.405149] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
> [ 9339.433816] NFS: server nvgm022 error: fileid changed
> [ 9339.433819] fsid 0:25: expected fileid 0x15f5d7c, got 0x65be80
> [ 9340.149325] NFS: server nvgm022 error: fileid changed
> [ 9340.149328] fsid 0:25: expected fileid 0x7a6f3d, got 0x19bc55
> [ 9340.173278] NFS: server nvgm022 error: fileid changed
> [ 9340.173281] fsid 0:25: expected fileid 0x15f5d7c, got 0x22070e
> [ 9340.324517] NFS: server nvgm022 error: fileid changed
> [ 9340.324520] fsid 0:25: expected fileid 0x15f5d7c, got 0x11c9001
> 
> Thanks
> Martin
> 
> 
> ------------------------------------------------------
> Martin Knoblauch
> email: k n o b i AT knobisoft DOT de
> www:   http://www.knobisoft.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

