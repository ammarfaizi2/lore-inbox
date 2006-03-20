Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWCTIl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWCTIl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWCTIl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:41:57 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:13161 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751616AbWCTIl4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:41:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I29+53ExGhg5NrzgcG8YwIYbhKjd4xe7R3Titwzajl29VlLwrbQYtRv2lZFDq9NL1YkQp4C6C0S7dgXqm/NThULF7MYS21t9EjktNOUIN8H0Xu56Wd2EohzMI9cAFiyzvpNs3mcRYJ+/+MS8bchDU//8nMusQMNcAhV4Mc0gMvM=
Message-ID: <3faf05680603200041w49c5c59am46cf24bbb25cc013@mail.gmail.com>
Date: Mon, 20 Mar 2006 14:11:52 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: "Cedric Le Goater" <clg@fr.ibm.com>
Subject: Re: Idea to create a elf executable from running program [process2executable]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <441E68C6.7030107@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3faf05680603181422y7447fd7duc1032bd0e07b9c68@mail.gmail.com>
	 <441E68C6.7030107@fr.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why don't you let execve() finish its job before modifying the mapping ?
>
> Once execve returns, the segments are mapped and you are free to remap them
> however you want and fill them in with a state previously saved on disk.
>

I dont want to remap myself after execve() because considering the
potential problem of ASLR (Address Space Layout Randomization), since
the segments may contain sections merged into it especially the
segments with permissions 'rw-p' has .dynamic, .got sections merged
into it so if I do that after execve the .dynamic and .got are put
back with the old contents which crashes.

So I want to write the all the virtual adress mappings as PT_LOAD
segments and leave the mapping job to the elf loader itself.

Thank you,
Vamsi kundeti
