Return-Path: <linux-kernel-owner+w=401wt.eu-S932889AbXAADAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbXAADAj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 22:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933242AbXAADAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 22:00:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:60831 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932889AbXAADAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 22:00:38 -0500
In-Reply-To: <20061231161749.06e7f746.amit2030@gmail.com>
References: <20061231161749.06e7f746.amit2030@gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6123994155a57efb1f43c9c1c9b41d96@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Date: Mon, 1 Jan 2007 04:01:07 +0100
To: Amit Choudhary <amit2030@gmail.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define KFREE(x)		\
> +	do {			\
> +		kfree(x);	\
> +		x = NULL;	\
> +	} while(0)

This doesn't work correctly if "x" has side effects --
double evaluation.  Use a temporary variable instead,
or better, an inline function.  A better name wouldn't
hurt either (kfree_and_zero()?)


Segher

