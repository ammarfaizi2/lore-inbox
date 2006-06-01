Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965252AbWFAGEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbWFAGEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 02:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWFAGEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 02:04:42 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:5027 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965157AbWFAGEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 02:04:41 -0400
Date: Thu, 1 Jun 2006 10:04:24 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, "Brian F. G. Bidulock" <bidulock@openss7.org>
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060601060424.GA28087@2ka.mipt.ru>
References: <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20060531.114127.14356069.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 01 Jun 2006 10:04:27 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On Wed, May 31, 2006 at 11:41:27AM -0700, David Miller (davem@davemloft.net) wrote:
> > >   Worse: he folded the jenkins algorith result with
> > > 
> > >    h ^= h >> 16;
> > >    h ^= h >> 8;
> > > 
> > >   Destroying the coverage of the function.
> > 
> > It was done to simulate socket code which uses the same folding.
> > Leaving 32bit space is just wrong, consider hash table size with that
> > index.
> 
> You absolutely show not do this shifting on the jenkins hash
> result, you destroy the distribution entirely.  Just mask
> it with the hash mask and that's all you need to do.
> 
> Brian is right, this is absolutely critical to using the Jenkins hash
> correctly.  You're "unmixing" the bits it worked so hard to mix.

That is wrong. And I have a code and picture to show that, 
and you dont - prove me wrong :)

Attached code and picture which shows _exactly_ the same distribution for
folded and not folded Jenkins hash distribution, and it's artifact
compared to XOR hash.

Fairly distributed values being XORed produce still fairly distributed
value.

-- 
	Evgeniy Polyakov

--TakKZr9L6Hm6aLOc
Content-Type: image/png
Content-Disposition: attachment; filename="hash_comparison.png"
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAoAAAAHPEAIAAAAc2SATAAAACXBIWXMAAAsSAAALEgHS3X78
AAAb8UlEQVR42u3dW3bkKBYF0HIvTyGY//iIQWR/0F5JNokKhV5Id++PXC5ZVsgIu3zi8vjK
Oeec/wEAAIBH+48mAAAAIAIBGAAAgBAuC8BpUe/8kWtuPwcAAIDnuSwA5472zBJZy2eX4/H2
cwAAAHiqiYZA1wG1d6SNr3udAwAAwLNNEYDbgAoAAAD7+r725ZfrtLNRMQYAAPjMDFnvPzM0
QW3OkCn6AgAAbDFDqvqeoynuxFBtPvsh13PQc9Bn0HPQc9BnrvWfmZvguCWvzDoGAACI5rIK
cG/AcxtK6zN7kXWvcwAAAHiqL1FwhGEeAAAAn5knT020DzAAAKy1dm7hbIubznz/R7xWqpx5
hb2+l951LJp7FwIwAAChzRxdnhSr6qmIW/Z/MR6TLQRgAABCmG0tmJH7eXbYE2U5n22QAAC4
sS0hqt0lpL1me7wNrr1K5l731rvO8jkjy82OnDN+P9uN38/a63z2WuM1amH+LgRgAAAerldr
Hd8lpD2zt/XmyOuufcWR72jt/Yzf28iRkfZvPx655mevtRxlR15r5DrckQAMAMBj3XHY84iR
KyxHtTZg17Nz177WyN3O+SxmuJPX6x6h+v1+QpVbAAYAgEcZr15uqeve3Tzf6TOC5V1YBAsA
gAfaEuc+qw2mxjzxsv2OemE48hBfw5sjUAEGACC03mDg3pnL19lyJ/sOkO4t39U7std3sdc9
9+5neTbvSIwfeS1vBzzVl/XKxn8ZXftLAQCAOe0VXGerG4/fc++z/nKm7SfX9goVYAAAmMJ4
LXq2e/bsuAsBGAAANtk3BIqUcByLYAEAABCCAAwAwAprlwWabRmhme8/wpJL9SrZZ15hr7bt
XcdyWXchAAMAcKqZo4IYc1yb1At6bVlj2RBxthCAAQA4xGwrGI/cj3B1Jq3N+SyCBQDACltC
S7uDa3vN3l61vXOOuLfedZbPWbuH7ZbXGvleRtaUXr6fkee1r732JR6pLX/2vI74ueBMAjAA
ADvr1Vp7gbbVntl+VS+ujB/vveLId7T2fsbvba/dgJevM3I/489r5E7aj0e+x7Wvvnyd8dca
uQ53JAADALCbOw57HjFyheVo1KvH9t4m2P69z/MU9grSR/SNOe7k9bpDqM75/b5/lVsABgCA
TcarhdvruuxlpjcInhAs78IiWAAA7GBLnPusFpca88TL9jvqheE7Dql96jBgw5sjUAEGAOBU
I4szLR8f+eyIfQdI95bv6h3Z67vY65579zP+vM65n+XZvCNvK4y81n3fnmDZl0EXI85Z9Q4A
gBF7BdfZ6sbj99z77Pl3Ptv9MH+/vbZXqAADABDUObXNI+7Z/cBnBGAAAG5m39AlwkEcFsEC
AAAgBAEYAABCW7vU02xLQ81wP5bLugsBGAAA2ET84y4EYAAAYMhsq2TPv2o3sxGAAQAgtC0B
st2Vt60Gt8eXz+ldZ+39LB9ffq2R72uvNuRMAjAAAPAverXW+kiutFeoN51qN6Bqr9A7Z+R+
2vja2+15+bXaMw32vjvbIAEAAF13HPbchu3PXms58O/5Hb1e8/eEnHN+v+/enwVgAACAyzwj
WN6FIdAAAMBfbKmgbpnBW+sNXR6/c4OWqakAAwAAm7RRc3km8PJ1ttxJG5Lb4dDLM5A9zWf7
8pjHf5D8YAAAwBFsaBTh+ZaPr33KhkADAAAQggAMAABcTO2XcwjAAAAAhCAAAwAAEIIADAAA
QAgCMAAAACEIwAAAAIQgAAMAABCCAAwAAEAIAjAcLqWUXi/tAAAA1xKAAQAACEEABgAAIAQB
GA5k8DMAAMxDAAYAACAEARgAAIAQBGA4XM45v9+GQwMAwLUEYAAAAEIQgAEAAAhBAAYAACAE
ARgOUWb8ltm/7XHtAwAA5xOAYWciLgAAzEkAhpO01WAAAOBMAjAAAAAhfF/78imllFJ9JOec
c+59tndmfX57fO05sJ16LwAAzOayANwLou3xkbBaf9XIlcVgAACAaG4/BLoXmOvq8cg5AAAA
PNtlAXht9TVVPDbm1Nv6qHemFgMAgDN9z3Mr44Oirx3A3AvhBlQzosRjARgAgKeauWw5RQDu
BVqREgAAgL1MsQr0vYKuWA4AANDTG9U7w71dNgd4fMuikcZdu+SVVaABAACimW4f4CJXlvcK
ro8sx1obIAEAAER2WQAej6D7nin6AgAAxHT7fYABAABghAAMAABACAIwAAAAIQjAAAAAhCAA
AwAAEIIADDtIKaXXK+ec32+tAQAAcxKAAQAACEEABgAAIAQBGAAAgBAEYAAAAEIQgAEAAAhB
AAYAACAEARgAAIAQBGC4QNkxuOwerDUAAOAcAjAAAAAhCMAAAACEIADDJmUYcxnSrDUAAGBm
AjAAAAAhCMAAAACEIAADAAAQggAMF7MZEgAAnEMABgAAIAQBGAAAgBAEYAAAAEIQgAEAAAhB
AAYAACAEARguk3PO77d2AACAcwjAAAAAhCAAAwAAEIIADAAAQAgCMAAAACEIwAAAAIQgAAMA
ABCCAAwfSiml18tWRgAAcBcCMAAAACEIwAAAAIQgAMPFyiDqMqBaawAAwHEEYAAAAEIQgAEA
AAhBAAYAACAEARgAAIAQBGAAAABCEIABAAAIQQAGAAAgBAEYAACAEARgAAAAQhCAAQAACEEA
BgAAIAQBGAAAgBAEYAAAAEIQgAEAAAhBAAYAACAEARgAAIAQBGAAAABCEIABAAAIQQAGAAAg
BAEYVksppdcr55zfb60BAAB3IQADAAAQggAMAABACBcH4NRYPnPkatvPAQAA4HkuC8AliOZG
G1DrM3vxda9zAAAAeKqph0DXkbUcaePrXucAAADwbJcF4DqOAgAAwNG+57mVtk47p17dWKQH
AACYeaTtFEOg7xJ94YyfhddLOwAAwBEurgDfMfoK6hzVr95vARgAgLtrE9M8NeEpVoFebrgj
lrxScwYAAIhmigpwe7wXX3uRda9zAAAAeKrLAvDaCDpy/l7nAAAA8DxT7wMMAAAAexGAAQAA
CEEABgAAIAQBGAAAgBAEYAAAAEIQgAEAAAhBAAYAACAEARgAAIAQBGAAAABCEIABAAAIQQCG
FVJK6fXSDgAAcEcCMKyWc87vt3YAAIB7EYABAAAIQQAGAAAgBAEYAACAEARgAAAAQhCAAQAA
CEEABgAAIAQBGAAAgBAEYJhI2WE4pZReL60BAAD7EoABAAAIQQAGAAAgBAEYAACAEARgAAAA
QhCAAQAACEEABgAAIAQBGAAAgBAEYAAAAEIQgAEAAAhBAAYAACAEARgAAIAQBGAAAABCEIAB
AAAIQQCGISml9Hqd81o55/x+n/mKAAAQgQAMK5Roqh0AAOCOBGAAAABCEIABAAAIQQAGAAAg
BAEYAACAEARgAAAAQhCAAQAACEEABgAAIAQBGAAAgBAEYAAAAEIQgAEAAAhBAAYAACAEARgA
AIAQBGAAAABCEIABAAAIQQAGAAAgBAEYAACAEARgAAAAQhCAAQAACEEABgAAIAQBGKaWUkqv
l3YAAIDtBGCYVM45v9/aAQAA9iIAAwAAEIIADAAAQAgCMAAAACEIwAAAAIQwRQBOKaWUesd7
xq+z9hwAAACe5/valx+JoznnnPPIdcqZ9cdrzwEAAOCpLqsA7xVB2+vUEXf8HAAAAJ7tsgC8
NvouD34GAACAZd/z32Jbv712AHMvhBtQDQAAMHPZcuoALFICAACwlxtUgGcjlgMAAPT0FiSe
4d6m3gd4fI3otUteWQUaAAAgmssqwG24rY/kSntmG1xHNjeyARIAAEBklwXg8Qi675miL5/3
2PdbOwAAwH1NPQQa5pFSSq+XdgAAgPsSgAEAAAhBAAYAACAEARgAAIAQBGAAAABCEIABAAAI
QQAGAAAgBAEYAACAEARgAAAAQhCAAQAACEEAhn+RUkqvV845v99aAwAA7ksABgAAIAQBGAAA
gBAEYAAAAEIQgAEAAAhBAAYAACAEARgAAIAQBGAAAABCEIABAAAIQQCGG0gppddLOwAAwBYC
MEwt55zfb+0AAADbCcAAAACEIAADAAAQggAMAABACAIwAAAAIQjAAAAAhCAAAwAAEIIADAAA
QAgCMAAAACEIwAAAAIQgAAMAABCCAAwAAEAIAjAAAAAhCMAAAACEIAADAAAQggAMAABACAIw
dKWU0uuVc87vt9YAAIC7E4ABAAAIQQAGAAAgBAEYbqMMydYOAADwGQEYbsA8ZAAA2E4ABgAA
IAQBGAAAgBAEYAAAAEIQgAEAAAhBAAYAACAEARgAAIAQBGAAAABCEIABAAAIQQAGAAAgBAEY
AACAEARgAAAAQhCAAQAACEEABgAAIAQBGAAAgBAEYAAAAEIQgAEAAAhBAAYAACAEARhuJqWU
Xi/tAAAAa00RgFNKKaV5zoESMnPO+f2e565mux8AALiXiwPweGTNOeece+fvdQ4AAABPdVkA
ruPo+DltfN3rHAAAAJ7tsgC8HH0BAABgX9+aYK1e3VikBwAAmHmkrVWgAQAACEEFeDWVXgAA
gJ42Mc1TE566AnzcklcjS3ABAADwJJdVgNv3AOojvfjai6x7nQMAAMBTXRaA10bQkfP3OgcA
AIDnsQgWAAAAIQjAAAAAhCAAAwAAEIIADAAAQAgCMAAAACEIwHAzOef8fqeU0uulNQAAYJwA
DAAAQAgCMPyhVFZLlVVrAADAkwjAAAAAhCAAAwAAEIIADAAAQAgCMAAAACEIwAAAAIQgAAMA
ABCCAAwAAEAIAjAAAAAhCMAAAACEIAADAAAQggAMAABACAIwAAAAIQjAAAAAhCAAh/N6pZSS
dgAAAKIRgAEAAAhBAA4tpddLNRgAAIhBAOZ/DI1OKaXXK+ec3+/577bcZ7lnvRcAAEYIwAAA
AIQgAIfz9fXrl1YAAADiEYADqQc517N/zQQGAAAiEIADaWu/v359fWkXAAAgBgE4nJzf75y1
AwAAEI0ADAAAQAgCcGjvd84/1eAyQNpmSAAAwFMJwEHVs38NigYAACIQgIOqa78t60IDAADP
IwDzB7sEAwAATyUA8z/1QOgyQFodGAAAeBIBGAAAgBAEYP5QL44FAADwJAIwf1GWyKoHQtse
aVndPtoKAADmJADzh+XVoVlLGAYAgHkIwCFsiWGlDvzs1aFTSun1yjnn93vfdraqNgAAzEMA
DqRe5/kz6pkjbVKq6AZFAwDAbATgED6rQxoOvbattBgAAMxMAH64snzVlrWdS6gr4c6A3lbd
Jr2dk8s5dR3YHssAAHC+b00A29WB9udjbxYAAMBcVIBDMDT3HO0s6/bIEfOByyJe2h8AAJYJ
wA9k597zjSwwdsTbENtXrgYAgDgE4Mcq8063zP7tMX91uQW2r7YNAAAcQQB+uH2rjqJdbXyB
sdJu3jgAAIBrCcCPImKdr/cWQ+/Ngroy73kBAMCZBOAHOmLYM4XICgAA9yUAP5bhytoWAACo
CcB8qKwyba3pcb3YrA0BAOAcAjCrlSBX5rJqh8++1s7MAABwPgH4gYSrI4yv+QwAAMxJAIYV
tr+50KsbW14LAACOJgDDvxBNAQDgGQTgh7CQ0n3tUVXO+f0ui5JpTwAA6BGAH6IsSXX+9jzl
de8bv2cIjXWFWbUZAACOM3UATot6549c04Pf7kl74ZYK6t96y+uVUvlOj1j+qm5Dy2sBAMDR
vue/xZz/fYBoibXlzPrjtecAAADwVLcfAt1G2Trijp8DAADAs90mAC8PfuZaZSbwU5UZzkfv
rlxf35JmAABwhBsMgW7rt9cOYO6F8Kvu5ycsXRNByyzWMlf2nKD4PO1s6t9vKPzMQNZKAADc
xcxly6kDsDm6AAAA7OUGFeDZiOUc2bve75xLLf3ZA8sBAHiq3oLEM9zbDbZBGmnctUtePWkV
6Kt2AP7zKbzfOd99T+A/+97rldIdtyaaYWdjAACY09QBuA6utTa4jmxu9LwNkCyVdE6rnj+r
uX7FEsVHf17+tpsxAABQPGQf4PEzDWDmLkr92UBoAADYy+33AYbjWNEaAACeRABmN/VM4PnN
P1dW/AYAgH0JwLdUrxI85z6xd5mfXM+bnXntZfO9AQBgOwEY/mLOtxUAAIAtBGAAAABCEIBv
aebBz1oVAACYkwDMzu61FBYAABCHAAxT84YCAADsRQC+mZReL6sBRzW+FvT8mzwBAMD5BOBb
+vXr60sr7OdJmwzVGzsBAAA1AfiW3u+cLdQUj4HQAACwhQDMgeasrJbhwXWldP71n+t7Mwwe
AAA+IwADAAAQggDMgeYfsnvH2b+lGqwODAAAawnAt1ECz12Wv5p5OPF9aVUAANhCAOZwapUA
AMAMBGBCm3/5q2XeXAAAgHECMCeZLardfe/fkcHwZb1rfQ8AAAoB+GbutQNwqayauXp0T2jf
XKg3eQIAAAoBGG7sLouiAQDADARg4JbuPogdAIDzCcA3cK8NkO5i/j2KR9QDoeMEQkt/AQDw
GQGYQNpFocxPvq9nvIUBAMCZBGBONUft7pnV9LsHwrpv9KrZvdEQasIAAIwQgDmJWqu2HVfC
fInBJdz2Im4dletzRGIAAFoC8G3cawOkmT17NvWTgl+JweV5lX+9jQIAwBYCMOF4K2E29cDm
OsCXuLtloS91YAAAagIwQT27ljh/8Fu+w/bp1DG4/rie+dxG6MKGSQAAFALw1J5Xv+pFFPZt
4bv06rU9oY6+dUi2SRgAACME4Bt40h/3Vw0/jhC5ezXtOb/3uleXj0vf+KwyX7627V3lyjZM
AgCgEIC5jIGpx/mJlzMGwDb6HnH9NkjXa0rrIQAAMQnAXKCEk3NjWZQqYF0FnXPsQHkSx40F
GJktLAYDAMQkAE+qro4+e9Xio+vAf64qnPP7HaH/tH1mhsh3xD2MDJk2WxgAgEIAnlS9Ayqf
UeWb862Tulf35u4ewR7CAAAIwFzmuIHQdfT1JgI9ZqEDAEQjAE/t2YOfj6biN4PyZkT5t17t
+dqfqXpxMDEYACAOAXg6Mf8cP2K4cmlJbyIU5+/A3NbhPQsAAK4lAHMxQ5TP8fX1zz9nrYM9
f/QVxQEAYhKApxNlu54f+0aREr0Mfq61a1+fUwe+V9XXQGgAgAgE4EnFjHD1fNEt16kHP5fr
xdkAqd+jSgsc+wbLHWNk2yLCMADAUwnATKEdCG0To5n1ImIdJuev/dZvM7ULYrXfo2AMAHB3
AvBE/HldAsnaWcFtVDbDc227lb438qZDLyLWX3uv8QttDK77jzdiAACeRABmInWgKrFkPH4I
KuPqyFfara7ctgPR63hczqyD4jNavm2TtndFm58PAPA8AvBEIv95Xdfcyscj9fB6d9nC8lfL
ykzgn3nRpaV/t1jbeuUp1D2zbu12tef7t8/f+4+1ygEAnkEAnk7kCNcbulwHrTU1YctfrVPi
bgl7pR+20bc8ozY2t8fvTr0XAOB5BGAmVQJVr95Yf/y86HW+OsT2Pjt+/BmtUT5uxxd89nYM
AAAz+NYEM/BndM/vSPbnUFvVuTPa/M8oGHNpMQuqAQA8iQrwRNQwl1umNwQXztdbARsAgJkJ
wNxGW4vrxeAy+1eL9dRLYWmNfistvcliDAIAwB0JwDyW5a84vo/9Dsl32cdbvRoAiEwABlih
VxkuNeF6z+Tz760N4ctDtdu7FY8BgGcTgKdgl1F4hnOGRveqzeOv3l5hOfrWn71LrRsAoCUA
T8F8wr2Y1zrOTOBtrff3rZL+7I3/Xlldjp0jS22Vc+oz67pumTlff229jnr5t975uXw8cudi
MABwRwLwxcofl9Y03pfZv5yp3Tiq/onuhcnex3WgLQG1PbMebl2OlyPldes31OqvXd7tuVyt
/mwbm+tQXX+VgdMAwF0IwJdRP9mXSqbWu9by21htfbU+0hoZFVLO6QXa+n5697Z8vN1+rH31
XtjuHQEAuJYAfBnDno+g9qvFZmrb/68Gl/8ukXK54lpfoZxf/9tWmHtxdyT6/r7Lv53Z1reX
X3GkJuztPwDgKt+a4FoGP0NMvWBZD2bunV9/1fl3vhy2v75+/fpz0HU7lLowAQQAOJ8AfIGf
6ocK8D5KtUklk7vo1Vp7g417589pueZcx2MAgPMJwBfoVXjgWt5K4AjLQ7J7g6V7vyHVjQGA
LcLNAS6z0zx4qAm9M7hXpXe/vvf3DaV6GzuVI5bXAgA+EygAlz+gci67Yl4Tg8sfbb11X/nk
mc69dnGqaFWe3XO2qLdoqncqbjdeahcAq/89egmuI5bv+myPaH0Gv23Qc+AzIQJwHX3LkfNj
cB19Y9Z59n+mPyFN9XIvdUuKwVxlfN3pemXsot2WqY7E9crb9ZH61evz2/2Z6x2Y24r02o2g
elcYr3WrhAPAWuYAH67+A0X03aM9zVM9Vmnb+k9xrc0V/fDfN3P6/6j85wzhdlXt30tw/fxO
/h2Yf8fIX7/aUP2zbGF9nfpV/nZ+udZPNfvnnHYDvPp47+ORGFxft/y81qF9eda0mdUAxPFV
10Wfqq0ALx/vXUF3AQAA2OLaBBpuESwAAABiMgR6SIQ6OQAAwLOFqAC3S16ND34GAADgGULM
Aa6JvgAAADGFC8AAAADEZBEsAAAAQhCAAQAACEEABgAAIAQB+EP1mtIw3iv2Oocn9ZmansN4
b1nuOfoMnz13PYf6Kfudw/aes6U/HNFnBOAPH2q7tRJ6xfaeo3dF6zO50T53PYcid/htw170
HFojv3n0HNqnPPPfNgLwhw+1/qXgx1ivWF5NfaTn6F3oOWzvIfoMI33GbxuO+y2k59Ca7f9T
AjDs9iMNeg7nsKc9+gzn9x+RlWcQgAGm4M9TxvtJ+zHAEdpBrX7zMNJnZn7T5NtDAriW6Mu4
5dl32oeWHsJn9Bn26jmz/RZSAQa4jD9MgXO01Rh1PCAmAXiFkSna8FnP0buiGXm+eg5tn/Hb
hrV66/duX4RGz/E7R8/hs99I1/aZL51vyy8Frcfy/x4+GwSid+k5eg7jPWdkMyR9hvHnrufQ
Puv6iJ7D3fuMAAwAAEAIhkADAAAQggAMAABACAIwAAAAIQjAAAAAhCAAAwAAEIIADAAAQAgC
MAAAACEIwAAAAIQgAAMAABCCAAwAAEAIAjAAAAAhCMAAAACE8L32C1JKKaX6SM4557z2nPb8
5XNG7qT3isv3M36d8y23zF7PYu3z+qxvzNzOAABABCsCcC+M1cdHztn3G/gsWtfHx+PlmZZf
fa9nsdfzGr+OoAsAAFzl4iHQ14bM5bu6Kqpd++r7EncBAIB5rAjAI2Fme83wM6ly90eyVzvP
HD6f9LwAAIC7+N7yxSMh9uh6Znv9dnjz+BzX+1ZfP3sWvfbZcg/L7bz8vPxAAgAAx/kwAG+J
vnsFnpErnD8n+Xzb34YYWRbrsycyMtcaAADgHKvnAO9V9W0Hwc6w6NS9QtoMFXgAAIC7WBGA
94pbuVEf711z/PjRZpi/uu/bEGtfd8s9+5EDAACu8rV22areZ0dmk66deXvmPrfjldJzZjVv
b+e99kk+/xwAAIAjfM0fP+YZxGs4sRYAAADu67+3YjkA9sC3kgAAAABJRU5ErkJggg==

--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="test.c"

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

typedef unsigned int u32;
typedef unsigned short u16;
typedef unsigned char u8;

typedef unsigned int __u32;
typedef unsigned short __u16;
typedef unsigned char __u8;

#include "jhash.h"

struct hash_entry
{
	unsigned long		counter;
};

static inline num2ip(__u8 a1, __u8 a2, __u8 a3, __u8 a4)
{
	__u32 a = 0;

	a |= a1;
	a << 8;
	a |= a2;
	a << 8;
	a |= a3;
	a << 8;
	a |= a4;

	return a;
}

static inline __u8 get_random_byte(void)
{
	return 1 + (int) (255.0 * (rand() / (RAND_MAX + 1.0)));
}

static inline __u16 get_random_word(void)
{
	return 1 + (int) (65536.0 * (rand() / (RAND_MAX + 1.0)));
}

unsigned int hash_addr(__u32 faddr, __u16 fport, __u32 laddr, __u16 lport)
{
	unsigned int h = (laddr ^ lport) ^ (faddr ^ fport);
	h ^= h >> 16;
	h ^= h >> 8;
	return h;
}

unsigned int hash_addr1(__u32 faddr, __u16 fport, __u32 laddr, __u16 lport)
{
	u32 ports;
	unsigned int h;

	ports = lport;
	ports <<= 16;
	ports |= fport;

	h = jhash_2words(faddr, laddr, ports);
	//h ^= h >> 16;
	//h ^= h >> 8;

	return h;
}

int main()
{
	struct hash_entry *table;
	__u32 saddr, daddr;
	__u16 sport, dport;
	unsigned int hash, i, *results;
	unsigned int hash_size = 65536, iter_num = 100;

	table = malloc(hash_size * sizeof(struct hash_entry));
	if (!table)
		return -ENOMEM;
	
	results = malloc(hash_size * sizeof(unsigned int));
	if (!results)
		return -ENOMEM;

	for (i=0; i<hash_size; ++i) {
		results[i] = 0;
		table[i].counter = 0;
	}

	srand(time(NULL));

	daddr = num2ip(192, 168, 0, 1);
	dport = htons(80);
	
	for (i=0; i<hash_size*iter_num; ++i) {
		saddr = num2ip(get_random_byte(), get_random_byte(), get_random_byte(), get_random_byte());
		sport = get_random_word();

		hash = hash_addr(saddr, sport, daddr, dport);
		hash &= (hash_size - 1);

		table[hash].counter++;
	}

	for (i=0; i<hash_size; ++i)
		results[table[i].counter]++;
	
	for (i=0; i<hash_size; ++i)
		printf("%u %u\n", i, results[i]);
		//printf("%u %u\n", i, table[i].counter);
}

--TakKZr9L6Hm6aLOc--
