Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUJAVdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUJAVdD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUJAVcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:32:19 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29708 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266513AbUJAVWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:22:55 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] reduce sha512_transform() stack usage, speedup
Date: Sat, 2 Oct 2004 00:22:45 +0300
User-Agent: KMail/1.5.4
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
References: <200410012231.51816.vda@port.imtp.ilyichevsk.odessa.ua> <200410012338.11301.vda@port.imtp.ilyichevsk.odessa.ua> <20041001134322.237b8930.davem@davemloft.net>
In-Reply-To: <20041001134322.237b8930.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410020022.45946.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 October 2004 23:43, David S. Miller wrote:
> On Fri, 1 Oct 2004 23:38:11 +0300
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> 
> > WARNING: compile tested only.
> 
> You can't claim a "speed up" if you only compile test your
> changes.  Neither can you expect us to apply patches in
> such a case.

Speedup is rather tiny, most probably not measurable.
Patch optimizes out some memsets, otherwise code
practically did not change.
 
> It's not that difficult to load the tcrypt module and make
> sure all the tests for the module you're changing still
> pass.

Done:

testing sha384
test 1:
cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7
pass
test 2:
3391fdddfc8dc7393707a65b1b4709397cf8b1d162af05abfe8f450de5f36bc6b0455a8520bc4e6f5fe95b1fe3c8452b
pass
test 3:
09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039
pass
test 4:
3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
pass
testing sha384 across pages
test 1:
3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
pass

testing sha512
test 1:
ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f
pass
test 2:
204a8fc6dda82f0a0ced7beb8e08a41657c16ef468b228a8279be331a703c33596fd15c13b1b07f9aa1d3bea57789ca031ad85c7a71dd70354ec631238ca3445
pass
test 3:
8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909
pass
test 4:
930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
pass
testing sha512 across pages
test 1:
930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
pass

Please consider applying.
--
vda

