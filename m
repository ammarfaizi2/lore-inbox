Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWHXSA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWHXSA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbWHXSA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:00:59 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:39360 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1751613AbWHXSA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:00:58 -0400
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
From: David Safford <safford@watson.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Serge E Hallyn <sergeh@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       David Safford <safford@us.ibm.com>, kjhall@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-security-module-owner@vger.kernel.org
In-Reply-To: <20060824131127.GB7052@elf.ucw.cz>
References: <20060817230213.GA18786@elf.ucw.cz>
	 <OFA16BD859.1B593DA2-ON852571CE.005FA4FF-852571CE.004BD083@us.ibm.com>
	 <20060824054933.GA1952@elf.ucw.cz>
	 <20060824130340.GB15680@sergelap.austin.ibm.com>
	 <20060824131127.GB7052@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 14:00:54 -0400
Message-Id: <1156442454.2476.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 15:11 +0200, Pavel Machek wrote:
> Hmm.. you are the security expert here :-). But it still needs private
> key while accessing the net.. so even if it does read from
> ~/.ssh/private_key, first,  what stops mozilla from waiting for
> ssh to start talking on the network, and then read the key from ssh's
> memory?

I think the only good way to protect a private key is not to
let the application see it at all, either by pushing the signature
operation into a wrapper, or into the kernel key ring, or even better,
into a hardware token, such as a TPM. Secrecy is really hard. There
are classes of software covert channels which have been proven to
be undetectable, so if you let software (particularly a browser)
see your private key, it may well not be your key any more.

> Do you have examples where this security model stops an attack?
> 								Pavel

The main goal of this model is to stop some of the most common real 
attacks on client machines, in particular the downloading and execution
of malicious code, through a browser or email attachment. By making
the email and browser applications run in an untrusted level, we can
keep them from modifying user or system level files, and any files they
create are labeled untrusted so that even system level processes can't 
accidentally invoke them at a trusted level. Also, we can control what 
applications are allowed to install packages, so that only signed packages 
(which are initially labeled as untrusted, since they came in over the net), 
are promoted and installed by the guard (e.g. rpm).

In one demo I like to run, I deliberately download a trojaned game, and
run it both as a user and even as root/system. Since the game is labeled
untrusted, it is invoked untrusted regardless of who runs it.

dave


