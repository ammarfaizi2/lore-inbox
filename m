Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbUADR6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUADR6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:58:41 -0500
Received: from dsl-hkigw4g29.dial.inet.fi ([80.222.54.41]:5762 "EHLO
	dsl-hkigw4g29.dial.inet.fi") by vger.kernel.org with ESMTP
	id S264410AbUADR6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:58:40 -0500
Date: Sun, 4 Jan 2004 19:58:38 +0200 (EET)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4g29.dial.inet.fi
To: linux-kernel@vger.kernel.org
Subject: [HOWTO] Fetching current kernels with rsync and cvs
Message-ID: <Pine.LNX.4.58.0401041945590.468@dsl-hkigw4g29.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If you want to, you can also fetch current Linux kernels with rsync and
cvs using following script. Script will currently create $HOME/src/bkcvs,
$HOME/src/linux-2.4 and $HOME/src/linux-2.5 directories, which will hold
about 1100 megabytes of data. Run $HOME/bin/pull-kernels again later to
keep source trees up to date.

Best regards,
Petri Koistinen


mkdir -p $HOME/bin $HOME/src
cat >$HOME/bin/pull-kernels <<"EOF"
#!/bin/bash

HOST=rsync.kernel.org

rsync -avz --delete rsync://$HOST/pub/scm/linux/kernel/bkcvs $HOME/src
pushd $PWD >/dev/null
cd $HOME/src/bkcvs
for kernel_version in `ls -d linux*`
do
        echo $kernel_version
        [ -d $HOME/src/$kernel_version ] && (cd $HOME/src/$kernel_version && cvs update -dPA 2>/dev/null | grep -v '^?')
        [ -d $HOME/src/$kernel_version ] || (cd $HOME/src && cvs -d $HOME/src/bkcvs co $kernel_version)
done
popd >/dev/null
EOF
chmod +x $HOME/bin/pull-kernels
$HOME/bin/pull-kernels


