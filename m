Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUECLfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUECLfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 07:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUECLfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 07:35:07 -0400
Received: from users.linvision.com ([62.58.92.114]:21925 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261711AbUECLfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 07:35:01 -0400
Date: Mon, 3 May 2004 13:35:00 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading from file in module fails
Message-ID: <20040503113500.GB31513@harddisk-recovery.com>
References: <20040503105041.GA12023@Loki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503105041.GA12023@Loki>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 12:50:41PM +0200, Libor Vanek wrote:
> I need to copy files (yes - I know that kernel shouldn't do this but
> I REALLY need).

This is ugly, but it should do the trick:

int rv;
char *argv[4] = {"/bin/cp", "/tmp/foo", "/tmp/bar", NULL};
char *envp[3] = {"HOME=/", "PATH=/sbin:/bin:/usr/sbin:/usr/bin", NULL};

rv = call_usermodehelper(argv[0], argv, envp, 1);

if(rv < 0) {
	/* error handling */
}

Called from kernel, done in userspace. And if you want to access an SQL
database from kernel tomorrow, it's just a matter of changing the
usermode helper.

(BTW, if you need to copy files from kernel, it's usually a sign of bad
design)


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
