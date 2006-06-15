Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWFOFCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWFOFCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 01:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWFOFCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 01:02:43 -0400
Received: from main.gmane.org ([80.91.229.2]:36773 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932336AbWFOFCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 01:02:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: patch for "bizarre read bug" in klibc dash
Date: Thu, 15 Jun 2006 11:02:25 +0600
Message-ID: <4490E9E1.30607@ums.usu.ru>
References: <bda6d13a0606142019m439c8eavca9afd955930d324@mail.gmail.com>	 <4490D9A1.8010405@ums.usu.ru> <bda6d13a0606142145r11628ec2w788117ee2d418e59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.220.94.212
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
In-Reply-To: <bda6d13a0606142145r11628ec2w788117ee2d418e59@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson wrote:
> Oh, and the original code that found this long ago:
> grep MemFree /proc/meminfo | read J MEMFREE K
> case $MEMFREE in
> ...
> (MEMFREE used several times below)
> 
> Had to convert to:
> 
> MEMFREE=`grep MemFree /proc/meminfo | (READ J M K ; echo $M)`
> case $MEMFREE in
> ...

Pure-shell implementation:

while read J M K ; do
     case "$J" in
     MemFree:)
         MEMFREE="$M"
     esac
done </proc/meminfo
case $MEMFREE in
...

-- 
Alexander E. Patrakov

