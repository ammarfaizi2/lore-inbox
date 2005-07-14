Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVGNRAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVGNRAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVGNRAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:00:18 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:56428 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261577AbVGNQ7s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:59:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lCaIh1MOv2OSFUAbe2Antt/QS70r6ExsgjWK2e0amPwYkdW4DZPv+NkLhPg9NoD12NGXCkYZiPBLSR/WmJtpcqINAkRQLZvRLNDJoofMN8sa34pZg7bnGQLVKhPt3496VuXorZsYaJWJeJbJBGWoKvH8WdBaHjKJTeTiYgG3SOY=
Message-ID: <e1e1d5f405071409592890b1d7@mail.gmail.com>
Date: Thu, 14 Jul 2005 09:59:01 -0700
From: Daniel Bonekeeper <thehazard@gmail.com>
Reply-To: Daniel Bonekeeper <thehazard@gmail.com>
To: S <talk2sumit@gmail.com>
Subject: Re: LKM function call on kernel function call?
Cc: linux-kernel@vger.kernel.org,
       linux prg <linux-c-programming@vger.kernel.org>
In-Reply-To: <1458d9610507050123124d6cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1458d9610507050123124d6cb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can also look about some methods of "function redirection
hooks"... add some opcodes at the start of the "hooked function"
(something like to add a CALL or JMP pointing to the address of your
function). There are docs about this subject, but unfortunately I
couldn't find anything now (http://www.ouah.org/p59-0x08.txt is not
exactly what I'm talking about, it's talking about ELF redirection).
It's a dirty thing to do, and it's not intended to be done in any
production thing (in fact, it's a *hack*).

On 7/5/05, S <talk2sumit@gmail.com> wrote:
> Is it possible to code a loadable module having function1(), which
> would be called, everytime a particular function of the kernel is
> called? If not, atleast a way this could be done without re-compiling
> the whole kernel and rebooting the system?
> 
> Example:
> 
> My LKM:
> -------------
> 
> init_module() {
> ...
> }
> 
> function1() {
> ...
> }
> 
> cleanup_module() {
> ...
> }
> 
> 
> I want function1() to be called, everytime the function
> ide_do_rw_disk() of ide-disk.c is called. I do not want to re-compile
> the complete kernel to do this.
> 
> Thanks in advance,
> 
> Regards,
> S
> -
> To unsubscribe from this list: send the line "unsubscribe linux-c-programming" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
