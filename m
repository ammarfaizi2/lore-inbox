Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293303AbSCBRzK>; Sat, 2 Mar 2002 12:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293479AbSCBRzB>; Sat, 2 Mar 2002 12:55:01 -0500
Received: from geminib.tcd.ie ([134.226.16.162]:10799 "HELO mail.tcd.ie")
	by vger.kernel.org with SMTP id <S293303AbSCBRys>;
	Sat, 2 Mar 2002 12:54:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nick Murtagh <murtaghn@tcd.ie>
To: Ville Herva <vherva@niksula.hut.fi>
Subject: Re: strange su behaviour
Date: Sat, 2 Mar 2002 17:54:46 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020302001706.9CCCBC7B@mail.tcd.ie> <20020302090832.GT1105@niksula.cs.hut.fi>
In-Reply-To: <20020302090832.GT1105@niksula.cs.hut.fi>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020302175446.EAB87C08@mail.tcd.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 March 2002 09:08, Ville Herva wrote:
> Well, you could try to strace it to see where it lurks when it hangs.

The -r did the trick. Basically there was a bug in pam_xauth where it
was calling ftruncate with an un-initialised off_t length. Hence it
was trying to ftruncate a 34 byte file to > 100 megabytes. 

The ftruncate manpage says that the behaviour in this circumstance is
undefined. I will investigate further to see why different kernel
versions are acting differently here.

Thanks for your help.

Nick
