Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWBFPvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWBFPvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 10:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWBFPvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 10:51:43 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:6030 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S932101AbWBFPvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 10:51:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=FvlNaBoaHhFOt0SShSF9mPF7DGzrdCdRBRWxUkxuEAHv0vp43moA/nqI/bF8zLacXw7HRdEQqtF8QfP/nbNCeXOSRrVrr0UqEJd2esNJ78ZrJTxQ/Y1W5IezrR6pcgZbNu8Vki/eni1FdbmjO+/+0Tw/r92KUSpzzv4acVv3Iuw=;
Date: Mon, 6 Feb 2006 18:51:01 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, arjan@infradead.org,
       frankeh@watson.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
Message-ID: <20060206155101.GA22522@ms2.inr.ac.ru>
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com> <20060203140229.GA16266@ms2.inr.ac.ru> <43E38D40.3030003@fr.ibm.com> <20060206094843.GA6013@ms2.inr.ac.ru> <20060206145104.GB11887@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206145104.GB11887@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> into the pidhash, or make the first exec()d process the container's
> init?  Does that seem reasonable?

It is exactly what openvz does, the first task becomes child reaper.

Cedric asked why do we have an init in each container, I answered that
we want to. But openvz approach is enough flexible not to do this, nothing
will break if a container process is reparented to normal init.

The question was not about openvz, it was about (container,pid) approach.
How are you going to reap chidren without a child reaper inside container?
If you reparent all the children to a single init in root container,
what does wait() return? In openvz it returns global pid and child is buried
in peace. If you do not have global pid, you cannot just return private pid.

Alexey
