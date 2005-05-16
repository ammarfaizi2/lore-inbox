Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVEPWIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVEPWIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEPWHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:07:51 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:62216
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S261935AbVEPWEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:04:48 -0400
Date: Mon, 16 May 2005 15:04:45 -0700
From: Brad Boyer <flar@allandria.com>
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
Cc: Valdis.Kletnieks@vt.edu, fs@ercist.iscas.ac.cn,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
Message-ID: <20050516220445.GA3681@pants.nu>
References: <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu> <20050517.051113.132843723.okuyamak@dd.iij4u.or.jp> <200505162035.j4GKZVCc018357@turing-police.cc.vt.edu> <20050517.063931.91280786.okuyamak@dd.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517.063931.91280786.okuyamak@dd.iij4u.or.jp>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 06:39:31AM +0900, Kenichi Okuyama wrote:
> USB storage is gone. And it SEEMS to came back.
> But how do you know that it's images were not changed.
> 
> Blocks you have cached might have different image. If you remount
> the file system, the cache image should be updated as well.
> 
> But very fact that *cache image should be updated* means, old cache
> image was invalid. And when did it become invalid?
> 
> When it was gone.
> 
> Think about thing this way. There was USB storage and it's cached
> image. Storage is somewhat gone. It never returned before reboot.
> Was cache image valid after storage gone? Ofcourse not. That cache
> is nothing more than old data which came from LOST, and NEVER COMING
> BACK device.
> 
> If device did come back but with change, we must read the data from
> storage again. Old cache image was useless, and was harmful.
> If device did come back without change, we can read the data from
> storage again.
> 
> No need to keep the cache image, taking risk of cache not being
> valid, especially while you have no control over the storage.

This is a difficult problem, but it's not as completely invalid as
you seem to think. The use case I remember taking advantage of in
actual experience is from the classic MacOS. The way the mac handled
floppies was very interesting. There was a way to eject an HFS floppy
without unmounting it. Using this trick, you could have multiple disks
mounted using the same physical drive. It kept as much as it could
in RAM to be able to use the files, and the system would block on
unknown sectors until the correct disk was reinserted. However, it's
very difficult to get this level of usage without full knowledge all
the way from the device driver up to the UI. Since Apple controlled
the whole thing, they could get away with this. I'm not sure we could
do an equivalent thing in as different of an environment as we have.
They could tell apart each filesystem, notify the user when a different
disk was needed, and everything else to have a seamless experience.

	Brad Boyer
	flar@allandria.com

