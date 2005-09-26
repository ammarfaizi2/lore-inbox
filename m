Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVIZMz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVIZMz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVIZMz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:55:29 -0400
Received: from verein.lst.de ([213.95.11.210]:60548 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932118AbVIZMz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:55:29 -0400
Date: Mon, 26 Sep 2005 14:55:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: sds@epoch.ncsc.mil, jmorris@namei.org
Cc: linux-kernel@vger.kernel.org
Subject: security/selinux/hooks.c:flush_unauthorized_files()
Message-ID: <20050926125522.GA25687@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, what is this code doing in a security module?

The check for unauthorized files should really move into
flush_old_files, removing the horrible devnull hack at the same time.

The tty loop isn't in the right place either, and it seems we might
be missing a call to disassociate_tty if the current process is the
session leader.  I'd suggest moving this code into fs/exec.c aswell,
aksing the security module for the actual permissions through an LSM
hook.
