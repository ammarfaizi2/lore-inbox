Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751878AbWFVTK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWFVTK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbWFVTK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:10:28 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:5835 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751878AbWFVTK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:10:27 -0400
Date: Thu, 22 Jun 2006 15:10:24 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
       David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 2/3] SELinux: add security_task_movememory calls to mm
 code
In-Reply-To: <20060622123102.GF27074@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0606221504370.21897@d.namei>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
 <Pine.LNX.4.64.0606211730540.12872@d.namei> <Pine.LNX.4.64.0606211734480.12872@d.namei>
 <20060622123102.GF27074@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Serge E. Hallyn wrote:

> sorry if I'm being dense - what is actually being protected against
> here?  The only thing I can think of is one process causing performance
> degradation to another by moving it's memory further from it's cpu on a
> NUMA machine.

This is a privileged operation, which currently relies only on uid (i.e. 
traditional Unix DAC), and capability checking.

SELinux introduces Mandatory Access Control (MAC) based upon all 
security-relevant attributes of tasks and objects, not just uid/capability 
checks.  Theoretically, all processes could run with euid==0 under SELinux 
(in fact, Russell Coker's 'play box' does something similar by giving out 
the root password to everyone, although SELinux is designed to complement 
DAC, not replace it).

Any privileged operations with DAC controls also need corresponding MAC 
controls, which is what this patch implements.



- James
-- 
James Morris
<jmorris@namei.org>
